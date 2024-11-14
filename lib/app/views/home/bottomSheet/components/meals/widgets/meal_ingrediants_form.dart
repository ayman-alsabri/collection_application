import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_units_adder.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/meals_sheet_controller.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/widgets/ingrediant_field_adder.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealIngrediantsForm extends StatelessWidget {
  const MealIngrediantsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MealsSheetController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const IngrediantFieldAdder(),
            const SizedBox(height: 16),
            const FoodUnitsAdder(opacity: 0.2,),
            const SizedBox(height: 24),
            PrimaryBlueButton(
              height: 50,
              width: 202,
              text: 'متابعة',
              onPressed: controller.submit,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
