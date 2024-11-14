import 'dart:isolate';
import 'dart:ui';

import 'package:collection_application/app/data/models/meal.dart';
import 'package:collection_application/app/data/stored/databases/convertor_extension.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  final DataController _dataController = Get.find();
  final _quantity = 15;

  String _previousText = ' ';
  int _maxPosition = 0;
  int _currentPosition = 0;
  final meals = <Meal>[].obs;
  final textController = TextEditingController(text: '');
  final isLoading = true.obs;
  final isFull = false.obs;

  Future<void> onSearch() async {
    final text = textController.text.trim();
    if (text == _previousText) return;
    meals.value = [];
    isLoading.value = true;
    final maxMeals = await _getMaxMeals(text);
    final newMeals = await _getData(text, 0, _quantity);
    _resetValues(newMeals, maxMeals);
    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<void> onLoadMore() async {
    if (_currentPosition >= _maxPosition) return;
    isLoading.value = true;
    final newMeals = await _getData(_previousText, _currentPosition, _quantity);
    meals.addAll(newMeals);
    _currentPosition += newMeals.length;

    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<void> onDeleteFood(Meal meal) async {
    await _dataController.deleteFood(meal);
    meals.remove(meal);
  }

  Future<int> _getMaxMeals(String startsWith) async {
    return await _databaseHelper.getLength('meal', startsWith);
  }

  Future<List<Meal>> _getData(
      String startsWith, int startPosition, int quantity) async {
    final rawMeals = await _databaseHelper.getMealsWithName(
        beginWith: startsWith, limit: quantity, offset: startPosition);
    return rawMeals.toMealList();
  }

  void _resetValues(List<Meal> newMeals, int maxMeals) {
    _currentPosition = newMeals.length;
    _maxPosition = maxMeals;
    meals.value = newMeals;
    _previousText = textController.text.trim();
  }

  bool _isFull() {
    return _currentPosition >= _maxPosition;
  }

  @override
  void onInit() {
    () async {
      final maxMeals = await _getMaxMeals('');
      final newMeals = await _getData('', 0, _quantity);
      _resetValues(newMeals, maxMeals);
      isLoading.value = false;
      isFull.value = _isFull();
    }();
    final port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, "meal");
    port.listen((dynamic data) async {
      final newText = _previousText;
      _previousText = ' ';
      textController.text = newText;
      await onSearch();
    });
    super.onInit();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('meal');

    Get.delete<MealsController>();
    super.dispose();
  }
}
