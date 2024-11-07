import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:sqflite/sqflite.dart';

mixin IngrediantMixin {
static const ingrediantsTableName = 'Ingrediant';

final mealId = 'id';
final foodId = 'foodId';
final unitId = 'unitId';
//quantity to make 100g of the meal
final quantity = 'quantity';

Future<void> onCreateMeal (Database db, int version)async{
 return db.execute('''
      CREATE TABLE $ingrediantsTableName (
        $mealId INTEGER NOT NULL,
        $foodId INTEGER NOT NULL,
        $unitId INTEGER NOT NULL,
        $quantity REAL NOT NULL,
        PRIMARY KEY ($mealId,$foodId,$unitId),
        FOREIGN KEY ($mealId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE,
        FOREIGN KEY ($foodId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE,
        FOREIGN KEY ($unitId) REFERENCES ${FoodMixin.unitTabelName}(${FoodMixin.unitId}) ON DELETE CASCADE
      )
    ''');
}

}