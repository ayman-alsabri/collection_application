import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class QrCodeContainer extends StatelessWidget {
  const QrCodeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.instanse;
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 12, bottom:0, top: 8),
      padding: const EdgeInsets.all(6.5),
      height: responsive.width(108),
      width: responsive.width(108),
      decoration: BoxDecoration(
        color: shadowColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Image.asset('assets/icons/QRcodePlaceholder.png'),
    );
  }
}
