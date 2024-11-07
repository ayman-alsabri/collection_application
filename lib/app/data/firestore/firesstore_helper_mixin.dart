import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:http/http.dart' as http;

const _foodTableName = 'Food';
const _foodId = 'id';
const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodType = 'type';
const _foodCategory = 'category';

const _productTableName = 'Product';
const _productId = 'id';
const _barcode = 'barCode';

const _unitTabelName = 'Unit';
const _unitName = 'name';
const _targetFoodId = 'foodId';
const _unitWeight = 'weight';

mixin FirestoreHelperMixin {
  final _firestore = FirestoreHelper.firestore;

  Future<void> addProduct(Product product) async {
    if (!await _checkInternetResult()) throw Exception('no Internet');

    await _addFoodFromTxn(_firestore, product, 'product');
    await _firestore
        .collection(_productTableName)
        .doc(product.id.toString())
        .set({
      _productId: product.id,
      _barcode: product.barCode,
    });
  }

  Future<void> addFood(Food food) async {
    if (!await _checkInternetResult()) throw Exception('no Internet');

    await _addFoodFromTxn(_firestore, food, 'food');
  }

  Future<void> setPoints(int points, String? email) async {
    if (!await _checkInternetResult()) throw Exception('no Internet');
    if (email == null) throw Exception('no email');
    await _firestore.collection('users').doc(email).update({'points': points});
  }

  Future<void> _addFoodFromTxn(FirebaseFirestore firestore, Food food,
      [String type = 'food']) async {
    await firestore.collection(_foodTableName).doc(food.id.toString()).set({
      _foodId: food.id,
      _name: food.name,
      _foodType: type,
      _foodCategory: food.category,
      _caloriesPer100g: food.caloriePer100g,
      _protinePer100g: food.protine,
      _carbPer100g: food.carbs,
      _fatPer100g: food.fat,
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw Exception('internet is slow'),
    );

    for (Unit unit in food.units) {
      await firestore.collection(_unitTabelName).doc(unit.id.toString()).set({
        _targetFoodId: food.id,
        _unitName: unit.name,
        _unitWeight: unit.weight
      });
    }
  }

  Future<bool> _checkInternetResult() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
