import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/food/widgets/food_units_adder_controller.dart';
import 'package:collection_application/custom/button/primary_white_button.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodUnitsAdder extends StatelessWidget {
  final double opacity;
  const FoodUnitsAdder({super.key, this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodUnitsAdderController>();
    return Obx(() => Column(
          children: [
            ...controller.units,
            const SizedBox(height: 8),
            PrimaryWhiteButton(
                opacity: opacity,
                onPressed: controller.addUnit,
                height: 50,
                width: Responsive.deviseWidth - 32,
                child: Text(
                  'اضافة وحدة',
                  style: TextStyle(
                    fontFamily: 'TITR',
                    color: opacity < 0.5
                        ? AppTheme.appTheme.colorScheme.onSecondary
                        : AppTheme.appTheme.colorScheme.secondary,
                    fontSize: Responsive.width(28),
                  ),
                ))
          ],
        ));
  }
}
