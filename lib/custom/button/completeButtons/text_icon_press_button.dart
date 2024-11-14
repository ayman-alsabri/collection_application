import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
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
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bottomGradientStartColor.withOpacity(0.7),
          boxShadow: const [
            BoxShadow(
              color: Colors.white12,
              offset: Offset(1, 1),
              blurRadius: 0.4,
            ),
            BoxShadow(color: cravedButtonTopShadow),
            BoxShadow(
                color: cravedButtonColor,
                offset: Offset(2, 2),
                spreadRadius: -2,
                blurRadius: 2),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'TITR',
                  fontSize: Responsive.width(13),
                  color: strokeGradientStartColor.withOpacity(0.6),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          BlueSqareButton(
            shadows: null,
            buttonSize: 24,
            borderRadius: 5,
            strokeOpacity: 0.6,
            iconName: iconName,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
