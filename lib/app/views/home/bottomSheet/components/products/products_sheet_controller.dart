import 'package:collection_application/app/views/home/bottomSheet/components/nutritional_value_container.dart';
import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsSheetController extends GetxController {
  static String _productName = '';
  final Rx<Widget> currentDisplayedForm = NutritionalValueContainer(
    onNameChanged: (name) => _productName = name,
  ).obs;
}
