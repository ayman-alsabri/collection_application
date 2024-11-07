import 'package:collection_application/app/views/home/bottomSheet/components/nutritional_value_field.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/products/products_sheet_controller.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/products/widgets/products_barcode_form.dart';
import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsBottomSheet extends StatelessWidget {
  const ProductsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsSheetController());

    return GeneralBottomSheet(
      onTap: controller.onTap,
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'بيانات المنتج',
      firstField: NutritionalValueField(
          onValueChanges: controller.setNutritionalValues),
      secondField: Obx(() {
        return ProductsBarcodeForm(
            canRequestFocus: controller.currentFormIndex.value == 1,
            productName: controller.productName.value,
            submit: controller.submit,
            onValueChanges: controller.setBarcodeValues);
      }),
    );
  }
}
