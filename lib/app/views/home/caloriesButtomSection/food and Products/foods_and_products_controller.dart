import 'package:collection_application/app/data/models/food.dart';
import 'package:collection_application/app/data/stored/databases/convertor_extension.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodsAndProductsController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  final _quantity = 5;

  String _previousText = ' ';
  int _maxPosition = 0;
  int _currentPosition = 0;
  final foods = <Food>[].obs;
  final textController = TextEditingController(text: '');
  final isLoading = true.obs;
  final isFull = false.obs;

  Future<void> onSearch() async {
    final text = textController.text.trim();
    if (text == _previousText) return;
    foods.value = [];
    isLoading.value = true;
    final maxFoods = await _getMaxFoods(text);
    final newFoods = await _getData(text, 0, _quantity);
    _resetValues(newFoods, maxFoods);
    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<void> onLoadMore() async {
    if (_currentPosition >= _maxPosition) return;
    isLoading.value = true;
    final newFoods = await _getData(_previousText, _currentPosition, _quantity);
    foods.addAll(newFoods);
    _currentPosition += newFoods.length;

    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<int> _getMaxFoods(String startsWith) async {
    final foodsLingth = await _databaseHelper.getLength('food', startsWith);
    final productsLingth =
        await _databaseHelper.getLength('product', startsWith);
    return foodsLingth + productsLingth;
  }

  Future<List<Food>> _getData(
      String startsWith, int startPosition, int quantity) async {
    final rawFoods = await _databaseHelper.getFoodsAndProductsWithName(
        beginWith: startsWith, limit: quantity, offset: startPosition);
    return rawFoods.toFoodList();
  }

  void _resetValues(List<Food> newFoods, int maxFoods) {
    _currentPosition = newFoods.length;
    _maxPosition = maxFoods;
    foods.value = newFoods;
    _previousText = textController.text.trim();
  }

  bool _isFull() {
    return _currentPosition >= _maxPosition;
  }

  @override
  void onInit() {
    () async {
      final maxFoods = await _getMaxFoods('');
      final newFoods = await _getData('', 0, _quantity);
      _resetValues(newFoods, maxFoods);
      isLoading.value = false;
      isFull.value = _isFull();
    }();
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<FoodsAndProductsController>();
    super.dispose();
  }
}
