import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerItem extends StatelessWidget {
  final String iconName;
  final String title;
  final int index;
  final dynamic page;

  const DrawerItem({
    super.key,
    required this.iconName,
    required this.title,
    required this.index,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashFactory: InkSplash.splashFactory,
        splashColor: gradientEndColor.withOpacity(0.4),
        highlightColor: Colors.transparent,
        onTap: () {
          Get.to(page,
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 300));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
              // color: gradientEndColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SizedBox(
                height: Responsive.width(24),
                width: Responsive.width(24),
                child: Image.asset(
                  'assets/icons/$iconName.png',
                  fit: BoxFit.fitHeight,
                  color: strokeGradientStartColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'SF MADA',
                    fontSize: 16,
                    color: strokeGradientStartColor.withOpacity(0.7)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
