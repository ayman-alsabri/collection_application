import 'dart:isolate';
import 'dart:ui';

import 'package:collection_application/app/data/models/product.dart';
import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:get/get.dart';

import 'package:collection_application/app/data/stored/databases/convertor_extension.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:flutter/material.dart';

class ProductsController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  final DataController _dataController = Get.find();
  final _quantity = 15;

  String _previousText = ' ';
  int _maxPosition = 0;
  int _currentPosition = 0;
  final products = <Product>[].obs;
  final textController = TextEditingController(text: '');
  final isLoading = true.obs;
  final isFull = false.obs;

  Future<void> onSearch() async {
    final text = textController.text.trim();
    if (text == _previousText) return;
    products.value = [];
    isLoading.value = true;
    final maxProducts = await _getMaxProducts(text);
    final newProducts = await _getData(text, 0, _quantity);
    _resetValues(newProducts, maxProducts);
    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<void> onLoadMore() async {
    if (_currentPosition >= _maxPosition) return;
    isLoading.value = true;
    final newProducts =
        await _getData(_previousText, _currentPosition, _quantity);
    products.addAll(newProducts);
    _currentPosition += newProducts.length;

    isLoading.value = false;
    isFull.value = _isFull();
  }

  Future<void> onDeleteFood(Product meal) async {
    await _dataController.deleteFood(meal);
    products.remove(meal);
  }

  Future<int> _getMaxProducts(String startsWith) async {
    return await _databaseHelper.getLength('product', startsWith);
  }

  Future<List<Product>> _getData(
      String startsWith, int startPosition, int quantity) async {
    final rawProducts = await _databaseHelper.getProductsWithName(
        beginWith: startsWith, limit: quantity, offset: startPosition);
    return rawProducts.toProductList();
  }

  void _resetValues(List<Product> newProducts, int maxPnewProducts) {
    _currentPosition = newProducts.length;
    _maxPosition = maxPnewProducts;
    products.value = newProducts;
    _previousText = textController.text.trim();
  }

  bool _isFull() {
    return _currentPosition >= _maxPosition;
  }

  @override
  void onInit() {
    () async {
      final maxProducts = await _getMaxProducts('');
      final newProducts = await _getData('', 0, _quantity);
      _resetValues(newProducts, maxProducts);
      isLoading.value = false;
      isFull.value = _isFull();
    }();
    final port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, 'product');
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
    IsolateNameServer.removePortNameMapping("product");
    Get.delete<ProductsController>();
    super.dispose();
  }
}
