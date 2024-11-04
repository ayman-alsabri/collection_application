import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomSnackBar(String title, String subtitle,
    {Duration duration = const Duration(milliseconds: 2200)}) async {
  Get.closeCurrentSnackbar();
  Get.snackbar(
    duration: duration,
    titleText: Text(
      title,
      style: TextStyle(fontFamily: 'TITR', fontSize: Responsive.width(20)),
    ),
    messageText: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        subtitle,
        style: TextStyle(fontFamily: 'SF MADA', fontSize: Responsive.width(16)),
      ),
    ),
    title,
    subtitle,
    borderColor: strokeGradientEndColor.withOpacity(0.2),
    borderWidth: 1,
    borderRadius: 16,
    margin: const EdgeInsets.all(8),
    snackPosition: SnackPosition.TOP,
    backgroundGradient: LinearGradient(
      colors: [
        gradientEndColor.withOpacity(0.8),
        gradientStartColor.withOpacity(0.8),
      ],
      begin: const Alignment(0, -1),
      end: const Alignment(0, 0),
    ),
    barBlur: 15,
    boxShadows: [
      BoxShadow(
        blurStyle: BlurStyle.outer,
        color: lightGrayShadowColor.withOpacity(0.5),
        blurRadius: 20,
      ),
      BoxShadow(
          blurStyle: BlurStyle.outer,
          color: shadowColor.withOpacity(0.4),
          blurRadius: 10)
    ],
  );
}
