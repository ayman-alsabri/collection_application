import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:sqflite/sqflite.dart';

mixin IngrediantMixin {
  static const ingrediantsTableName = 'Ingrediant';

  final mealId = 'id';
  final ingrediantFoodId = 'foodId';
//total weight cannot exceed 100g
  final weight = 'weight';

  Future<void> onCreateMeal(Database db, int version) async {
    return db.execute('''
      CREATE TABLE $ingrediantsTableName (
        $mealId INTEGER NOT NULL,
        $ingrediantFoodId INTEGER NOT NULL,
        $weight REAL NOT NULL,
        PRIMARY KEY ($mealId,$ingrediantFoodId),
        FOREIGN KEY ($mealId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE,
        FOREIGN KEY ($ingrediantFoodId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) 
      )
    ''');
  }
}
