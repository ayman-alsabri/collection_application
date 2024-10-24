import 'package:collection_application/app/auth/signup/widgets/qr_code_container.dart';
import 'package:collection_application/app/auth/signup/widgets/scan_button.dart';
import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:flutter/material.dart';

class QrCodeHandlerView extends StatelessWidget {
  const QrCodeHandlerView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.instanse;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'كود الخصم',
          style: TextStyle(
            fontFamily: 'SF MADA',
            fontSize: responsive.width(18),
          ),
        ),
        const SizedBox(height: 13),
        const ScanButton(),
        const QrCodeContainer(),
      ],
    );
  }
}
