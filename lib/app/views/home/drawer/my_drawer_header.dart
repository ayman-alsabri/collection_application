import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: Responsive.width(50),
          height: Responsive.width(50),
          decoration: BoxDecoration(
            color: gradientEndColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/logo.jpg',
              )),
        ),
        const SizedBox(width: 8),
        Text(
          'تجميع البيانات',
          style: TextStyle(
              fontFamily: 'TITR',
              fontSize: 20,
              color: strokeGradientStartColor.withOpacity(0.8)),
        )
      ],
    );
  }
}
