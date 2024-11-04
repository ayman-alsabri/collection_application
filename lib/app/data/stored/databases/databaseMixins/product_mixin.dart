import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:sqflite/sqflite.dart';

mixin ProductMixin {
    static const productTableName = 'Product';

    final _productId = 'id';
    final _barcode = 'barCode';
    final _weightInGram = 'weight';


  Future<void> onCreateProduct (Database db, int version)async{
  return db.execute('''
        CREATE TABLE $productTableName (
          $_productId INTEGER PRIMARY KEY,
          $_barcode INTEGER NOT NULL,
          $_weightInGram INTEGER NOT NULL,
          FOREIGN KEY ($_productId) REFERENCES ${FoodMixin.foodTableName}(${FoodMixin.foodId}) ON DELETE CASCADE
        )
      ''');
  }

}
