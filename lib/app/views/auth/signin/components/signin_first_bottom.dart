import 'package:collection_application/app/views/auth/signin/signin_screen_controller.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/custom/button/primary_white_button.dart';
import 'package:collection_application/templates/containers/secondary_curved_container.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SigninFirstBottom extends StatelessWidget {
  static   final List<Effect> effects = [
    const SlideEffect(
        begin: Offset(1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];
  const SigninFirstBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInScreenController controller = Get.find();
    return SecondaryCurvedContainer(
      padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PrimaryBlueButton(onPressed: controller.openSecondPage,
            height: 50,
            width: 339,
            child: Text(
              'تسجل الدخول',
              style: TextStyle(
                fontFamily: 'TITR',
                color: AppTheme.appTheme.colorScheme.onPrimary,
                fontSize: Responsive.height(28),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryWhiteButton(
            onPressed: controller.toggleMethod,
            height: 50,
            width: 339,
            child: Obx(() {
              return Text(
                controller.useEmail.value ? 'رقم الهاتف' : 'الإيميل',
                style: TextStyle(
                  fontFamily: 'TITR',
                  color: AppTheme.appTheme.colorScheme.secondary,
                  fontSize: Responsive.width(28),
                ),
              ).animate(
                  autoPlay: false,
                  effects: controller.textChangeEffects,
                  target: controller.animateText.value ? 1 : 0);
            }),
          )
        ],
      ),
    );
  }
}
