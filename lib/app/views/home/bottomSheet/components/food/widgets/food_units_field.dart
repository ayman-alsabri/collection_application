import 'package:collection_application/app/views/home/bottomSheet/components/food/food_sheet_controller.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_units_adder.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodUnitsField extends StatelessWidget {
  const FoodUnitsField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodSheetController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const FoodUnitsAdder(),
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
