import 'dart:convert';
import 'dart:ui';

import 'package:collection_application/app/data/messaging/notification_helper.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/ingrediant_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/product_mixin.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodType = 'type';
const _foodCategory = 'category';
const _isMine = 'isMine';
const _name = 'foodName';

const _unitName = 'name';
const _targetFoodId = 'foodId';
const _unitWeight = 'weight';

const _productId = 'id';
const _barcode = 'barCode';

const _mealId = 'id';
const _ingrediantFoodId = 'foodId';
const _weight = 'weight';

class FirebaseMessagingController extends GetxController {
  static final _firebasemessaging = FirebaseMessaging.instance;
  FirebaseMessaging get firebaseMessaging => _firebasemessaging;

  Future<void> subscribeTo([String topic = 'collection_application']) async {
    return firebaseMessaging.subscribeToTopic(topic);
  }

  void _initMessaging() {
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandaler);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  @override
  void onInit() {
    _initMessaging();
    super.onInit();
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundMessageHandaler(RemoteMessage message) async {
  await _handleMessage(message);
}

@pragma('vm:entry-point')
Future<void> _handleMessage(RemoteMessage message) async {
  final data = message.data;
  final String mission = data['mission'];
  final userEmail = await UserDataHelper().getEmail();

  if (mission == 'add') {
    final Map<String, dynamic> foodDataMap = jsonDecode(data['foodData']);
    if (foodDataMap['senderData']['email'] == userEmail) return;

    final Map<String, dynamic> food = foodDataMap['food'];
    await NotificationHelper()
        .showNotification(food['id'], data['title'], data['body']);

    switch (food[_foodType]) {
      case 'food':
        await (await DatabaseHelper().database).transaction((txn) async {
          await _insertFoodWithUnits(food, foodDataMap, txn);
        });
        break;
      case 'product':
        await (await DatabaseHelper().database).transaction((txn) async {
          await _insertFoodWithUnits(food, foodDataMap, txn);
          await txn.rawInsert('''
                                INSERT INTO ${ProductMixin.productTableName}($_productId,$_barcode)
                                 VALUES(?,?)''',
              [food['id'], foodDataMap['barcode']]);
        });
        break;
      case 'meal':
        await (await DatabaseHelper().database).transaction((txn) async {
          await _insertFoodWithUnits(food, foodDataMap, txn);

          final List? ingrediantIds =
              (foodDataMap['ingrediantIds'])?.split('/');
          final List? ingrediantsWeights =
              (foodDataMap['ingrediantWeights'])?.split('/');
          const sqlString =
              '''INSERT INTO ${IngrediantMixin.ingrediantsTableName}($_mealId,$_ingrediantFoodId,$_weight) VALUES''';
          String valuesSting = '';
          final values = [];
          String idsString = '';
          final ids = [];

          if (foodDataMap['ingrediantIds'].isEmpty) return;
          for (var i = 0; i < (ingrediantIds ?? []).length; i++) {
            valuesSting += ',(?,?,?)';
            values.addAll([
              food['id'],
              int.parse(ingrediantIds![i]),
              double.parse(ingrediantsWeights![i]),
            ]);

            idsString += ',?';
            ids.add(int.parse(ingrediantIds[i]));
          }
          idsString = idsString.substring(1);
          await txn.rawUpdate('''
                                    UPDATE ${FoodMixin.foodTableName} 
                                    SET $_isMine = 0
                                    WHERE id IN ($idsString)''', ids);
          if (valuesSting.isNotEmpty) {
            await txn.rawInsert(sqlString + valuesSting.substring(1), values);
          }
        });
        break;
    }
    final sendPort = IsolateNameServer.lookupPortByName(food[_foodType]);
    if (sendPort != null) {
      sendPort.send(['']);
    }
    return;
  }

  if (data['senderEmail'] == userEmail) return;
  final foodId = int.parse(data['foodId']);
  await (await DatabaseHelper().database).transaction((txn) async {
    txn.rawDelete('''
                      DELETE FROM
                       ${FoodMixin.foodTableName} 
                       WHERE ${FoodMixin.foodId} = ?
                      ''', [foodId]);
  });
  await NotificationHelper().showNotification(foodId, data['title'], '');
  final sendPort = IsolateNameServer.lookupPortByName(data['body']);
  if (sendPort != null) {
    sendPort.send(['']);
  }
}

@pragma('vm:entry-point')
Future<void> _insertFoodWithUnits(Map<String, dynamic> food,
    Map<String, dynamic> foodDataMap, Transaction txn) async {
  await txn.rawInsert('''INSERT INTO ${FoodMixin.foodTableName}
              ('id',$_name,$_foodType,$_foodCategory,$_caloriesPer100g,$_protinePer100g,$_carbPer100g,$_fatPer100g,$_isMine) 
              VALUES (?,?,?,?,?,?,?,?,?)''', [
    food['id'],
    food[_name],
    food[_foodType],
    food[_foodCategory],
    food[_caloriesPer100g],
    food[_protinePer100g],
    food[_carbPer100g],
    food[_fatPer100g],
    0
  ]);
  const sqlString =
      '''INSERT INTO ${FoodMixin.unitTabelName}(${FoodMixin.unitId},$_targetFoodId,$_unitName,$_unitWeight) VALUES''';
  String valuesSting = '';
  final values = [];

  final List? unitIds = (foodDataMap['unitIds'])?.split('/');
  final List? unitNames = (foodDataMap['unitNames'])?.split('/');
  final List? unitWeights = (foodDataMap['unitWeights'])?.split('/');
  if (foodDataMap['unitIds'].isEmpty) return;
  for (var i = 0; i < (unitIds ?? []).length; i++) {
    valuesSting += ',(?,?,?,?)';
    values.addAll([
      int.parse(unitIds![i]),
      food['id'],
      unitNames![i],
      unitWeights![i],
    ]);
  }
  if (valuesSting.isNotEmpty) {
    await txn.rawInsert(sqlString + valuesSting.substring(1), values);
  }
}

Future<void> initFirebase() async {
  final apiKey = dotenv.env['API_KEY'];
  final appId = dotenv.env['APP_ID'];
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: apiKey!,
          appId: appId!,
          messagingSenderId: "359449937248",
          projectId: "data-collection-97956"));
}
