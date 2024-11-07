import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:sqflite/sqflite.dart';

mixin ProductMixin {
  static const productTableName = 'Product';

  final productId = 'id';
  final barcode = 'barCode';

  Future<void> onCreateProduct(Database db, int version) async {
    return db.execute('''
        CREATE TABLE $productTableName (
          $productId INTEGER PRIMARY KEY,
          $barcode TEXT NOT NULL,
          FOREIGN KEY ($productId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE
        )
      ''');
  }
}
