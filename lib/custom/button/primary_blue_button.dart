import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/templates/buttons/general_button.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class PrimaryBlueButton extends StatelessWidget {
  final void Function()? onPressed;
  final double width;
  final double height;
  final double backgroundOpacity;
  final String text;
  final List<BoxShadow> shadows;

  const PrimaryBlueButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.text,
    this.backgroundOpacity = 1,
    this.shadows = const [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 4, // Shadow blur
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return GeneralButton(
      shadows: shadows,
      height: height,
      width: width,
      strokeOpacity: backgroundOpacity * 0.2,
      colors: [
        bluegradientStartColor.withOpacity(backgroundOpacity),
        bluegradientEndColor.withOpacity(backgroundOpacity),
      ],
      onPressed: onPressed,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'TITR',
            color: AppTheme.appTheme.colorScheme.onPrimary,
            fontSize: Responsive.height(28),
          ),
        ),
      ),
    );
  }
}
