import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/data/models/unit.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/food/foods_controller.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/meals/meals_controller.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/products/products_controller.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DataController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  final _userDataHelper = UserDataHelper();

  final userName = ''.obs;
  final email = ''.obs;
  final points = 0.obs;

  Future<bool> addProduct(Product product) async {
    try {
      final newProduct = await _databaseHelper.addProduct(product);
      if (newProduct != null) {
        final ProductsController productsController = Get.find();
        newProduct.units = [
          Unit(id: 0, name: 'جرام', weight: 1),
          Unit(id: -1, name: '100 جرام', weight: 100),
          ...newProduct.units
        ];

        productsController.products.add(newProduct);
        points.value = await _userDataHelper.getPoints();
      }
    } on DatabaseException catch (_) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) =>
            showCustomSnackBar('لا يمكن الاضافة', "هذا العنصر موجود بالفعل"),
      );
      return true;
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> addFood(Food food) async {
    try {
      final newFood = await _databaseHelper.addFood(food);
      if (newFood != null) {
        final FoodsController foodsController = Get.find();
        newFood.units = [
          Unit(id: 0, name: 'جرام', weight: 1),
          Unit(id: -1, name: '100 جرام', weight: 100),
          ...newFood.units
        ];

        foodsController.foods.add(newFood);
        points.value = await _userDataHelper.getPoints();
      }
    } on DatabaseException catch (_) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) =>
            showCustomSnackBar('لا يمكن الاضافة', "هذا العنصر موجود بالفعل"),
      );
      return true;
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> addMeal(Meal meal) async {
    try {
      final newMeal = await _databaseHelper.addMeal(meal);
      if (newMeal != null) {
        final MealsController mealsController = Get.find();
        newMeal.units = [
          Unit(id: 0, name: 'جرام', weight: 1),
          Unit(id: -1, name: '100 جرام', weight: 100),
          ...newMeal.units
        ];
        mealsController.meals.add(newMeal);
        points.value = await _userDataHelper.getPoints();
      }
    } on DatabaseException catch (_) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) =>
            showCustomSnackBar('لا يمكن الاضافة', "هذا العنصر موجود بالفعل"),
      );
      return true;
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> deleteFood(Food food) async {
    await _databaseHelper.deleteFood(food);
    points.value = await _userDataHelper.getPoints();
  }

  @override
  void onInit() {
    () async {
      userName.value = await _userDataHelper.getUserName() ?? '';
      email.value = await _userDataHelper.getEmail() ?? '';
      points.value = await _userDataHelper.getPoints();
    }();
    super.onInit();
  }
}
