import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/templates/buttons/sqare_button.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class GreySqareButton extends StatelessWidget {
  final String iconName;
  final double padding;
  final double strokeOpacity;
  final List<BoxShadow>? shadows;
  final double? buttonSize;
  final double borderRadius;
  final Duration animationDuration;
  final void Function()? onPressed;

  const GreySqareButton({
    super.key,
    required this.iconName,
    this.onPressed,
    this.buttonSize,
    this.borderRadius = 10,
    this.strokeOpacity = 0.1,
    this.padding = 0,
    this.animationDuration = const Duration(milliseconds: 150),
    this.shadows = const [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 4,
      )
    ],
  });

  @override
  Widget build(BuildContext context) {
    return SqareButton(
      animationDuration: animationDuration,
      shadows: shadows,
      onPressed: onPressed,
      strokeOpacity: strokeOpacity,
      borderRadius: borderRadius,
      colors: [
        Color.alphaBlend(bluegradientStartColor.withOpacity(0.1),
            AppTheme.appTheme.scaffoldBackgroundColor),
        Color.alphaBlend(bluegradientEndColor.withOpacity(0.1),
            AppTheme.appTheme.scaffoldBackgroundColor),
      ],
      buttonSize: Size.square(Responsive.width(buttonSize ?? 44)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Image.asset('assets/icons/$iconName'),
      ),
    );
  }
}
