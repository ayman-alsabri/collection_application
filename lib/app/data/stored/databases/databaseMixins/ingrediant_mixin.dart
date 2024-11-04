import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:sqflite/sqflite.dart';

mixin IngrediantMixin {
static const ingrediantsTableName = 'Ingrediant';

final _mealId = 'id';
final _foodId = 'foodId';
final _unitId = 'unitId';
//quantity to make 100g of the meal
final _quantity = 'quantity';

Future<void> onCreateMeal (Database db, int version)async{
 return db.execute('''
      CREATE TABLE $ingrediantsTableName (
        $_mealId INTEGER NOT NULL,
        $_foodId INTEGER NOT NULL,
        $_unitId INTEGER NOT NULL,
        $_quantity REAL NOT NULL,
        PRIMARY KEY ($_mealId,$_foodId,$_unitId),
        FOREIGN KEY ($_mealId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE,
        FOREIGN KEY ($_foodId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE,
        FOREIGN KEY ($_unitId) REFERENCES ${FoodMixin.unitTabelName}(${FoodMixin.unitId}) ON DELETE CASCADE
      )
    ''');
}

}