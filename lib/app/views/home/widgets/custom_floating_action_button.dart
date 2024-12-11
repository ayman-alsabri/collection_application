import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget bottomSheet;
  const CustomFloatingActionButton({
    super.key,
    required this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return BlueSqareButton(
      shadows: const [
        BoxShadow(color: shadowColor, offset: Offset(0, 4), blurRadius: 4)
      ],
      iconName: 'add.png',
      padding: 15,
      buttonSize: 55,
      onPressed: () => Get.bottomSheet(
        enableDrag: false,
        bottomSheet,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
      ),
    );
  }
}
