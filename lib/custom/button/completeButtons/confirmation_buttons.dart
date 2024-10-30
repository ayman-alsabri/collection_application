import 'package:collection_application/custom/button/custom_elevated_button.dart';
import 'package:collection_application/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class ConfirmationButtons extends StatelessWidget {
  final String confirmText;
  final void Function()? onConfirmed;
  final String cancelText;
  final void Function()? onCanceled;
  const ConfirmationButtons({
    super.key,
    required this.cancelText,
    required this.confirmText,
    this.onCanceled,
    this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          height: Responsive.height(39),
          width: Responsive.width(115),
          text: confirmText,
          onPressed: onConfirmed,
        ),
        CustomElevatedButton(
          height: Responsive.height(39),
          width: Responsive.width(115),
          text: cancelText,
          onPressed: onCanceled,
        ),
      ],
    );
  }
}
