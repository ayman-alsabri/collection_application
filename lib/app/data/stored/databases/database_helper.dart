import 'package:collection_application/app/data/stored/databases/databaseMixins/food_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/ingrediant_mixin.dart';
import 'package:collection_application/app/data/stored/databases/databaseMixins/product_mixin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper with FoodMixin, IngrediantMixin, ProductMixin {
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
}
