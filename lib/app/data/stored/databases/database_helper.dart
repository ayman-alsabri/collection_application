import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/ingrediant_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/product_mixin.dart';
import 'package:collection_application/app/data/stored/databases/database_helper_mixin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper
    with FoodMixin, IngrediantMixin, ProductMixin, DatabaseHelperMixin {
  factory DatabaseHelper() => _instance;
  static final _instance = DatabaseHelper._intrnal();
  DatabaseHelper._intrnal();

  static Database? _oneTimeDatabase;
  Future<Database> get database async =>
      _oneTimeDatabase ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'food.db');
    return await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await onCreateFood(db, version);
    await onCreateProduct(db, version);
    await onCreateMeal(db, version);
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<bool> deleteFood(Food food) async {
    return deleteFoodFromDatabase(food, (await database));
  }

//products
  Future<Product?> addProduct(Product product) async {
    return await addProductToDatabase(product, await database);
  }

  Future<List<Map<String, dynamic>>> getProductsWithName({
    required String beginWith,
    required int limit,
    required int offset,
  }) async {
    return (await database).rawQuery('''SELECT 
          f.* ,
          GROUP_CONCAT(u.id, '/') AS unitIds,
          GROUP_CONCAT(u.$unitName, '/') AS unitNames,
          GROUP_CONCAT(u.$unitWeight, '/') AS unitWeights,
          p.$barcode
          FROM ${FoodMixin.foodTableName} f
          LEFT JOIN ${FoodMixin.unitTabelName} u ON f.id = u.$targetFoodId
          LEFT JOIN ${ProductMixin.productTableName} p ON f.id = p.$productId
           WHERE f.$foodType = 'product' AND f.$name LIKE ?
           GROUP BY f.id
           ORDER BY f.$name ASC 
           LIMIT $limit
           OFFSET $offset
  ''', ['$beginWith%']);
  }

// foods
  Future<Food?> addFood(Food food) async {
    return await addFoodToDatabase(food, await database);
  }

  Future<List<Map<String, dynamic>>> getFoodsWithName({
    required String beginWith,
    required int limit,
    required int offset,
  }) async {
    return (await database).rawQuery('''SELECT 
          f.* ,
          GROUP_CONCAT(u.id, '/') AS unitIds,
          GROUP_CONCAT(u.$unitName, '/') AS unitNames,
          GROUP_CONCAT(u.$unitWeight, '/') AS unitWeights
          FROM ${FoodMixin.foodTableName} f
          LEFT JOIN ${FoodMixin.unitTabelName} u ON f.id = u.$targetFoodId
           WHERE f.$foodType = 'food' AND f.$name LIKE ?
           GROUP BY f.id
           ORDER BY f.$name ASC 
           LIMIT $limit
           OFFSET $offset
  ''', ['$beginWith%']);
  }

//meals
  Future<Meal?> addMeal(Meal meal) async {
    return await addMealToDatabase(meal, await database);
  }

  Future<List<Map<String, dynamic>>> getMealsWithName({
    required String beginWith,
    required int limit,
    required int offset,
  }) async {
    return (await database).rawQuery('''SELECT 
          f.* ,
          GROUP_CONCAT(u.id, '/') AS unitIds,
          GROUP_CONCAT(u.$unitName, '/') AS unitNames,
          GROUP_CONCAT(u.$unitWeight, '/') AS unitWeights,
          GROUP_CONCAT(i.$ingrediantFoodId, '/') AS ingrediantIds,
          GROUP_CONCAT(i.$weight, '/') AS ingrediantsWeights
          FROM ${FoodMixin.foodTableName} f
          LEFT JOIN ${FoodMixin.unitTabelName} u ON f.id = u.$targetFoodId
          LEFT JOIN ${IngrediantMixin.ingrediantsTableName} i ON f.id = i.$mealId
           WHERE f.$foodType = 'meal' AND f.$name LIKE ?
           GROUP BY f.id
           ORDER BY f.$name ASC 
           LIMIT $limit
           OFFSET $offset
  ''', ['$beginWith%']);
  }

//store tables
  Future<void> storeFoods(List<Map<String, dynamic>> rawFoods) async {
    final sqlQuery = '''
                  INSERT INTO ${FoodMixin.foodTableName} (${FoodMixin.foodId}, $name, $foodType, $foodCategory, $caloriesPer100g, $protinePer100g, $carbPer100g, $fatPer100g, $isMine) VALUES
                      ''';
    String values = '';
    final args = [];

    for (var food in rawFoods) {
      values += ',(?,?,?,?,?,?,?,?,?)';
      args.addAll([
        food[FoodMixin.foodId],
        food[name],
        food[foodType],
        food[foodCategory],
        food[caloriesPer100g],
        food[protinePer100g],
        food[carbPer100g],
        food[fatPer100g],
        0
      ]);
    }

    if (values.isNotEmpty) {
      values = values.substring(1);
      (await database).rawQuery(sqlQuery + values, args);
    }
  }

  Future<void> storeUnits(List<Map<String, dynamic>> rawUnits) async {
    final sqlQuery = '''
                  INSERT INTO ${FoodMixin.unitTabelName} (${FoodMixin.unitId}, $targetFoodId, $unitName, $unitWeight) VALUES
                      ''';
    String values = '';
    final args = [];

    for (var unit in rawUnits) {
      values += ',(?,?,?,?)';
      args.addAll([
        unit[FoodMixin.unitId],
        unit[targetFoodId],
        unit[unitName],
        unit[unitWeight]
      ]);
    }
    if (values.isNotEmpty) {
      values = values.substring(1);
      (await database).rawQuery(sqlQuery + values, args);
    }
  }

  Future<void> storeIngrediants(
      List<Map<String, dynamic>> rawIngrediants) async {
    final sqlQuery = '''
                  INSERT INTO ${IngrediantMixin.ingrediantsTableName} ($mealId, $ingrediantFoodId, $weight) VALUES
                      ''';
    String values = '';
    final args = [];

    for (var ingrediant in rawIngrediants) {
      values += ',(?,?,?)';
      args.addAll([
        ingrediant[mealId],
        ingrediant[ingrediantFoodId],
        ingrediant[weight],
      ]);
    }
    if (values.isNotEmpty) {
      values = values.substring(1);
      (await database).rawQuery(sqlQuery + values, args);
    }
  }

  Future<void> storeProducts(List<Map<String, dynamic>> rawProducts) async {
    final sqlQuery = '''
                  INSERT INTO ${ProductMixin.productTableName} ($productId, $barcode) VALUES
                      ''';
    String values = '';
    final args = [];

    for (var product in rawProducts) {
      values += ',(?,?)';
      args.addAll([
        product[productId],
        product[barcode],
      ]);
    }
    if (values.isNotEmpty) {
      values = values.substring(1);
      (await database).rawQuery(sqlQuery + values, args);
    }
  }

//
  Future<int> getLength(String type, String beginWith) async {
    final queryResult = await (await database).rawQuery('''SELECT
         COUNT(*) as length
         FROM ${FoodMixin.foodTableName}
         WHERE $foodType = ? AND $name LIKE ?''', [type, '$beginWith%']);
    return queryResult.first['length'] as int;
  }

  //only for this app
  Future<List<Map<String, dynamic>>> getFoodsAndProductsWithName({
    required String beginWith,
    required int limit,
    required int offset,
  }) async {
    return (await database).rawQuery('''SELECT 
          f.* ,
          GROUP_CONCAT(u.id, '/') AS unitIds,
          GROUP_CONCAT(u.$unitName, '/') AS unitNames,
          GROUP_CONCAT(u.$unitWeight, '/') AS unitWeights
          FROM ${FoodMixin.foodTableName} f
          LEFT JOIN ${FoodMixin.unitTabelName} u ON f.id = u.$targetFoodId
           WHERE f.$foodType = 'food' OR f.$foodType = 'product' AND f.$name LIKE ?
           GROUP BY f.id
           ORDER BY f.$name ASC 
           LIMIT $limit
           OFFSET $offset
  ''', ['$beginWith%']);
  }
}
