import 'package:sqflite/sqflite.dart';

mixin FoodMixin {
  static const foodTableName = 'Food';

  static const foodId = 'id';
  final _name = 'foodName';
  final _caloriesPer100g = 'caloriesPer100g';
  final _protinePer100g = 'protine';
  final _carbPer100g = 'carb';
  final _fatPer100g = 'fat';
  final _foodType = 'type';
  final _foodCategory = 'category';
  final _isMine = 'isMine';

  static const unitTabelName = 'Unit';

  static const unitId = 'id';
  final _unitName = 'name';
  final _targetFoodId = 'foodId';
  final _unitWeight = 'weight';

  Future<void> onCreateFood(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $foodTableName (
        $foodId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_name TEXT NOT NULL,
        $_foodType TEXT NOT NULL,
        $_foodCategory TEXT,
        $_caloriesPer100g INTEGER NOT NULL,
        $_protinePer100g REAL NOT NULL,
        $_carbPer100g REAL NOT NULL,
        $_fatPer100g REAL NOT NULL,
        $_isMine INTEGER DEFAULT 0,
      
        CHECK ($_isMine IN (0,1)),
        CHECK ($_foodType IN ('food', 'meal', 'product')),
        CHECK (
              ($_protinePer100g IS NULL AND $_carbPer100g IS NULL AND $_fatPer100g IS NULL) OR
              ($_protinePer100g IS NOT NULL AND $_carbPer100g IS NOT NULL AND $_fatPer100g IS NOT NULL)
            )
      )
    ''');
    return db.execute('''
        CREATE TABLE $unitTabelName (
          $unitId INTEGER AUTOINCREMENT ,
          $_targetFoodId INTEGER NOT NULL,
          $_unitName TEXT NOT NULL,
          $_unitWeight REAL NOT NULL,
          FOREIGN KEY ($_targetFoodId) REFERENCES $foodTableName($foodId) ON DELETE CASCADE
        )
      ''');
  }
}
