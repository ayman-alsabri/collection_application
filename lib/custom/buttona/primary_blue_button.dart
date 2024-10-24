import 'package:collection_application/custom/buttona/general_button.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class PrimaryBlueButton extends StatelessWidget {
  final void Function()? onPressed;
  final double width;
  final double height;
  final double backgroundOpacity;
  final Widget child;
  final List<BoxShadow> shadows;

  const PrimaryBlueButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.child,
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
      height: height,
      width: width,
      colors: [
        bluegradientStartColor.withOpacity(backgroundOpacity),
        bluegradientEndColor.withOpacity(backgroundOpacity),
      ],
      backgroundOpacity: backgroundOpacity,
      onPressed: onPressed,
      child: child,
    );
  }
}
