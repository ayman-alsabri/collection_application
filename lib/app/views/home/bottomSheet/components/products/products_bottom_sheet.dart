import 'package:collection_application/app/views/home/bottomSheet/components/products/products_sheet_controller.dart';
import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsBottomSheet extends StatelessWidget {
  const ProductsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsSheetController());
    return Obx(() {
      return GeneralBottomSheet(
        firstButtonName: 'القيمة الغذائية',
        secondButtonName: 'بيانات المنتج',
        child: controller.currentDisplayedForm.value,
      );
    });
  }
}
