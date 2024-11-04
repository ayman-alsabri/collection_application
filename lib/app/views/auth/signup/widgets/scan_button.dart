import 'package:collection_application/custom/button/completeButtons/text_icon_press_button.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final double width;
  const ScanButton({super.key, this.width = 69});

  @override
  Widget build(BuildContext context) {
    return const TextIconPressButton(
      iconName: 'videoCamera.png',
      text: 'مسح',
      width: 102,
    );
  }
}
