import 'package:collection_application/templates/buttons/general_button.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class PrimaryWhiteButton extends StatelessWidget {
  final void Function()? onPressed;
  final double width;
  final double height;
  final Widget child;
  const PrimaryWhiteButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralButton(
      height: height,
      width: width,
      colors: [emailButtonColor, emailButtonColor],
      onPressed: onPressed,
      child: child,
    );
  }
}
