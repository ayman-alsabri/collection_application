import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/product_mixin.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:sqflite/sqflite.dart';

const _name = 'foodName';
const _caloriesPer100g = 'caloriesPer100g';
const _protinePer100g = 'protine';
const _carbPer100g = 'carb';
const _fatPer100g = 'fat';
const _foodType = 'type';
const _foodCategory = 'category';
const _isMine = 'isMine';

const _productId = 'id';
const _barcode = 'barCode';

const _unitName = 'name';
const _targetFoodId = 'foodId';
const _unitWeight = 'weight';

mixin DatabaseHelperMixin {
  final _userDataHelper = UserDataHelper();
  final _firestoreHelper = FirestoreHelper();

  Future<Product?> addProductToDatabase(
      Product product, Database database) async {
    Product? newProduct;
    await (database).transaction(
      (txn) async {
        final food = await _addFoodFromTxn(product, txn, 'product');

        newProduct = Product.fromFood(food, product.barCode);
        await FirestoreHelper().addProduct(newProduct!);

        await txn.rawInsert(
            '''INSERT INTO ${ProductMixin.productTableName}($_productId,$_barcode) VALUES (?,?)''',
            [
              newProduct!.id,
              product.barCode,
            ]);
        await addProductPoints(product.units);
      },
    );
    return newProduct;
  }

  Future<void> addProductPoints(List<Unit> units) async {
    int points = 8;
    for (var i = 0; i < units.length; i++) {
      points += 1;
    }
    await _addPoints(points);
  }

  Future<Food?> addFoodToDatabase(Food food, Database database) async {
    Food? newFood;
    await (database).transaction(
      (txn) async {
        newFood = await _addFoodFromTxn(food, txn, 'food');
        await FirestoreHelper().addFood(newFood!);

        await addFoodPoints(food.units);
      },
    );
    return newFood;
  }

  Future<void> addFoodPoints(List<Unit> units) async {
    int points = 4;
    for (var i = 0; i < units.length; i++) {
      points += 1;
    }
    await _addPoints(points);
  }

  Future<Food> _addFoodFromTxn(Food food, Transaction txn, String type) async {
    final id = await txn.rawInsert('''INSERT INTO ${FoodMixin.foodTableName}
              ($_name,$_foodType,$_foodCategory,$_caloriesPer100g,$_protinePer100g,$_carbPer100g,$_fatPer100g,$_isMine) 
              VALUES (?,?,?,?,?,?,?,?)''', [
      food.name,
      type,
      food.category,
      food.caloriePer100g,
      food.protine,
      food.carbs,
      food.fat,
      1
    ]);

    final newUnits = <Unit>[];
    for (Unit unit in food.units) {
      final newUnitId = await txn.rawInsert(
          '''INSERT INTO ${FoodMixin.unitTabelName}($_targetFoodId,$_unitName,$_unitWeight) VALUES(?,?,?)''',
          [id, unit.name, unit.weight]);
      newUnits.add(Unit(id: newUnitId, name: unit.name, weight: unit.weight));
    }

    return Food(
        id: id,
        name: food.name,
        caloriePer100g: food.caloriePer100g,
        protine: food.protine,
        carbs: food.carbs,
        fat: food.fat,
        units: newUnits);
  }

  Future<void> _addPoints(int points) async {
    if (!await _userDataHelper.addPoints(points)) throw Error();
    await _firestoreHelper.setPoints(
        await _userDataHelper.getPoints(), await _userDataHelper.getEmail());
  }
}
