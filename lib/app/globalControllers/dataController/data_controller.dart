import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  final _userDataHelper = UserDataHelper();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Food> foods = <Food>[].obs;
  final RxList<Meal> meals = <Meal>[].obs;

  final userName = ''.obs;
  final points = 0.obs;

  Future<bool> addProduct(Product product) async {
    try {
      final newProduct = await _databaseHelper.addProduct(product);
      if (newProduct != null) {
        products.add(newProduct);
        points.value = await _userDataHelper.getPoints();
      }
    } catch (e) {
      return false;
    }
    return true;
  }
  Future<bool> addFood(Food food) async {
    try {
      final newFood = await _databaseHelper.addFood(food);
      if (newFood != null) {
        foods.add(newFood);
        points.value = await _userDataHelper.getPoints();
      }
    } catch (e) {
      return false;
    }
    return true;
  }
}
