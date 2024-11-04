import 'package:collection_application/app/views/auth/signup/widgets/qr_code_container.dart';
import 'package:collection_application/app/views/auth/signup/widgets/scan_button.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class QrCodeHandlerView extends StatelessWidget {
  const QrCodeHandlerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'كود الخصم',
          style: TextStyle(
            fontFamily: 'SF MADA',
            fontSize: Responsive.width(18),
          ),
        ),
        const SizedBox(height: 13),
        const ScanButton(),
        const QrCodeContainer(),
      ],
    );
  }
}
