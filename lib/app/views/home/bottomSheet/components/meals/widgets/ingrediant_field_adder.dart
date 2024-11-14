import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/components/meals/widgets/ingrediant_adder_controller.dart';
import 'package:collection_application/custom/button/primary_white_button.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngrediantFieldAdder extends StatelessWidget {
  const IngrediantFieldAdder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IngrediantAdderController>();
    return Obx(() => Column(
          children: [
            ...controller.ingrediantFields,
            const SizedBox(height: 8),
            PrimaryWhiteButton(
                onPressed: controller.addIngrediant,
                height: 50,
                width: Responsive.deviseWidth - 32,
                child: Text(
                  'اضافة مكون',
                  style: TextStyle(
                    fontFamily: 'TITR',
                    color: AppTheme.appTheme.colorScheme.secondary,
                    fontSize: Responsive.width(28),
                  ),
                ))
          ],
        ));
  }
}
