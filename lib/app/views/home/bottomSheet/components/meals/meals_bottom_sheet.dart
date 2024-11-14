import 'package:collection_application/app/views/home/bottomSheet/components/meals/meals_sheet_controller.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/widgets/meal_ingrediants_form.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/nutritional_value_field.dart';
import 'package:collection_application/templates/containers/general_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsBottomSheet extends StatelessWidget {
  const MealsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MealsSheetController());
    return GeneralBottomSheet(
      onTap: controller.onTap,
      firstButtonName: 'القيمة الغذائية',
      secondButtonName: 'المكونات',
      firstField: NutritionalValueField(
          onValueChanges: controller.setNutritionalValues),
      secondField: const MealIngrediantsForm(),
    );
  }
}
