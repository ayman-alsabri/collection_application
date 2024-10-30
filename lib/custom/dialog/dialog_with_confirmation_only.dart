import 'package:collection_application/custom/button/completeButtons/confirmation_buttons.dart';
import 'package:collection_application/custom/dialog/general_dialog.dart';
import 'package:collection_application/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class DialogWithConfirmationOnly extends StatelessWidget {
  final String title;
  final String subtitle;

  final String confirmText;
  final void Function()? onConfirmed;
  final String cancelText;
  final void Function()? onCanceled;

  const DialogWithConfirmationOnly({
    super.key,
    required this.title,
    required this.cancelText,
    required this.confirmText,
    this.subtitle = '',
    this.onCanceled,
    this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralDialog(
      // height: Responsive.height(182),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'SF MADA', fontSize: Responsive.width(24)),
          ),
          const SizedBox(height: 24),
          Text(
            subtitle,
            style: TextStyle(
                fontFamily: 'TITR', fontSize: Responsive.width(20)),
          ),
          const SizedBox(height: 24),
           Padding(
            padding: const EdgeInsets.all(16),
            child: ConfirmationButtons(
              confirmText: confirmText,
              cancelText: cancelText,
              onCanceled: onCanceled,
              onConfirmed: onConfirmed,
            ),
          )
        ],
      ),
    );
  }
}
