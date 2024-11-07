import 'package:collection_application/app/views/home/bottomSheet/components/food/food_sheet_controller.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_units_field.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/nutritional_value_field.dart';
import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodBottomSheet extends StatelessWidget {
  const FoodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodSheetController());
    return GeneralBottomSheet(
      onTap: controller.onTap,
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'وحدات القياس',
      firstField: NutritionalValueField(
        onValueChanges: controller.setNutritionalValues,
      ),
      secondField: const FoodUnitsField(),
    );
  }
}
