import 'package:collection_application/custom/button/primary_sqare_button.dart';
import 'package:collection_application/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class TextIconPressButton extends StatelessWidget {
  final String iconName;
  final String text;
  final double width;
  final void Function()? onPressed;
  const TextIconPressButton({
    super.key,
    required this.iconName,
    required this.text,
    this.onPressed,
    this.width = 69,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width(width),
      height: Responsive.height(30),
      padding: const EdgeInsets.only(bottom: 3, left: 8, right: 3, top: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bottomGradientStartColor.withOpacity(0.7)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimarySqareButton(
            iconName: iconName,
          ),
          Text(
            'مسح',
            style: TextStyle(
              fontFamily: 'TITR',
              fontSize: Responsive.width(13),
              color: strokeGradientStartColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
