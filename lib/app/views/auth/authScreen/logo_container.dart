import 'dart:ui';

import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      width: Responsive.width(250),
      height: Responsive.width(250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: shadowColor.withOpacity(0.6), blurRadius: 10)
        ],
        gradient: LinearGradient(colors: [
          gradientStartColor.withOpacity(0.4),
          gradientEndColor.withOpacity(0.4),
        ], begin: const Alignment(0.4, 0.55), end: const Alignment(0.5, 2.2)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/logo.jpg',
                width: Responsive.width(100),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'تجميع البيانات',
              style: TextStyle(
                  fontFamily: 'TITR',
                  fontSize: Responsive.width(28),
                  color: bluegradientStartColor),
            ),
            const Expanded(child: SizedBox()),
            Text(
              'معا لتطبيق أفضل',
              style: TextStyle(
                  fontFamily: 'TITR',
                  fontSize: Responsive.width(16),
                  color: strokeGradientStartColor.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
