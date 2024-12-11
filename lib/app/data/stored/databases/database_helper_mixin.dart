import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/ingrediant_mixin.dart';
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

const _mealId = 'id';
const _ingrediantFoodId = 'foodId';
const _weight = 'weight';

mixin DatabaseHelperMixin {
  final _userDataHelper = UserDataHelper();

// delete
  Future<bool> deleteFoodFromDatabase(Food food, Database database) async {
    try {
      await database.transaction(
        (txn) async {
          final foodType = (await txn.rawQuery(
            '''SELECT $_foodType as type
                   FROM ${FoodMixin.foodTableName}
                   WHERE ${FoodMixin.foodId} = ${food.id}''',
          ))
              .first['type'] as String;

          final effectedRows = await txn.rawDelete(
              'DELETE FROM ${FoodMixin.foodTableName} WHERE ${FoodMixin.foodId} = ?',
              [food.id]);
          if (effectedRows > 1) throw Error();
          await _subtractPoints(foodType, food.units);
          await FirestoreHelper().deleteFood(food);
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

//products
  Future<Product?> addProductToDatabase(
      Product product, Database database) async {
    Product? newProduct;
    await (database).transaction(
      (txn) async {
        final food = await _addFoodFromTxn(product, txn, 'product');

        newProduct = Product.fromFood(food, product.barCode);

        await txn.rawInsert(
            '''INSERT INTO ${ProductMixin.productTableName}($_productId,$_barcode) VALUES (?,?)''',
            [
              newProduct!.id,
              product.barCode,
            ]);
        await addProductPoints(product.units);

        await FirestoreHelper().addFood(
            food: newProduct!,
            barcode: newProduct!.barCode,
            ingrediants: [],
            units: newProduct!.units);
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

//foods
  Future<Food?> addFoodToDatabase(Food food, Database database) async {
    Food? newFood;
    await (database).transaction(
      (txn) async {
        newFood = await _addFoodFromTxn(food, txn, 'food');
        await addFoodPoints(food.units);
        await FirestoreHelper().addFood(
            food: newFood!,
            barcode: null,
            ingrediants: [],
            units: newFood!.units);
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

//meals
  Future<Meal?> addMealToDatabase(Meal meal, Database database) async {
    Meal? newMeal;
    await (database).transaction(
      (txn) async {
        final food = await _addFoodFromTxn(meal, txn, 'meal');

        newMeal = Meal.fromFood(food, meal.ingrediants);
        const sqlQuery =
            '''INSERT INTO ${IngrediantMixin.ingrediantsTableName}($_mealId,$_ingrediantFoodId,$_weight) VALUES''';
        String values = '';
        List<dynamic> args = [];
        String idsString = '';
        final ids = [];

        for (Ingrediant ing in meal.ingrediants) {
          values += ',(?,?,?)';
          args.addAll([newMeal!.id, ing.foodId, ing.weight]);

          idsString += ',?';
          ids.add(ing.foodId);
        }
        if (values.isNotEmpty) {
          idsString = idsString.substring(1);
          await txn.rawUpdate('''
                                    UPDATE ${FoodMixin.foodTableName} 
                                    SET $_isMine = 0
                                    WHERE id IN ($idsString)''', ids);
          await txn.rawInsert(sqlQuery + values.substring(1), args);
        }
        await addMealPoints(meal.units);

        await FirestoreHelper().addFood(
            food: newMeal!,
            barcode: null,
            ingrediants: newMeal!.ingrediants,
            units: newMeal!.units);
      },
    );
    return newMeal;
  }

  Future<void> addMealPoints(List<Unit> units) async {
    int points = 10;
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
        category: food.category,
        fat: food.fat,
        units: newUnits);
  }

  Future<void> _addPoints(int points) async {
    if (!await _userDataHelper.addPoints(points)) throw Error();
  }

  Future<void> _subtractPoints(String foodType, List<Unit> units) async {
    int points = foodType == 'food'
        ? 4
        : foodType == 'meal'
            ? 10
            : 8;
    for (var i = 0; i < units.length; i++) {
      points += 1;
    }
    points -= 2;
    return _addPoints(-points);
  }
}
