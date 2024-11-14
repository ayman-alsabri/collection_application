import 'package:sqflite/sqflite.dart';

mixin FoodMixin {
  static const foodTableName = 'Food';

  static const foodId = 'id';
  final name = 'foodName';
  final caloriesPer100g = 'caloriesPer100g';
  final protinePer100g = 'protine';
  final carbPer100g = 'carb';
  final fatPer100g = 'fat';
  final foodType = 'type';
  final foodCategory = 'category';
  final isMine = 'isMine';

  static const unitTabelName = 'Unit';

  static const unitId = 'id';
  final unitName = 'name';
  final targetFoodId = 'foodId';
  final unitWeight = 'weight';

  Future<void> onCreateFood(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $foodTableName (
        $foodId INTEGER PRIMARY KEY AUTOINCREMENT,
        $name TEXT NOT NULL UNIQUE,
        $foodType TEXT NOT NULL,
        $foodCategory TEXT,
        $caloriesPer100g INTEGER NOT NULL,
        $protinePer100g REAL NOT NULL,
        $carbPer100g REAL NOT NULL,
        $fatPer100g REAL NOT NULL,
        $isMine INTEGER DEFAULT 0,
      
        CHECK ($isMine IN (0,1)),
        CHECK ($foodType IN ('food', 'meal', 'product')),
        CHECK (
              ($protinePer100g IS NULL AND $carbPer100g IS NULL AND $fatPer100g IS NULL) OR
              ($protinePer100g IS NOT NULL AND $carbPer100g IS NOT NULL AND $fatPer100g IS NOT NULL)
            )
      )
    ''');
    return db.execute('''
        CREATE TABLE $unitTabelName (
          $unitId INTEGER PRIMARY KEY AUTOINCREMENT ,
          $targetFoodId INTEGER NOT NULL,
          $unitName TEXT NOT NULL,
          $unitWeight REAL NOT NULL,
          FOREIGN KEY ($targetFoodId) REFERENCES $foodTableName($foodId) ON DELETE CASCADE
        )
      ''');
  }
}
