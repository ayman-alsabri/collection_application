import 'package:collection_application/app/auth/authScreen/logo_container.dart';
import 'package:collection_application/app/auth/signin/signin_screen_view.dart';
import 'package:collection_application/app/auth/signup/signup_screen_view.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/globalControllers/authController/auth_controller.dart';
import 'package:collection_application/globalControllers/responsive.dart';
import 'package:collection_application/templates/authBackground/auth_screen_temp.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthscreenView extends StatelessWidget {
  const AuthscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    Get.put(AuthController());

    return AuthScreenTemp(
      body: Column(
        children: [
          SizedBox(
            height: Responsive.height(223),
          ),
          const LogoContainer(),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              PrimaryBlueButton(
                onPressed: () => Get.to(
                  () => const SignUpScreenView(),
                  transition: Transition.fadeIn,
                ),
                key: UniqueKey(),
                shadows: [
                  BoxShadow(
                    offset: const Offset(0, -20),
                    blurRadius: 30,
                    color: grayShadowColor.withOpacity(0.5),
                  ),
                  const BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: shadowColor,
                  ),
                ],
                height: 50,
                width: 371,
                child: Text(
                  'لنبدأ',
                  style: TextStyle(
                    color: AppTheme.appTheme.colorScheme.onPrimary,
                    fontFamily: 'TITR',
                    fontSize: Responsive.width(28),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryBlueButton(
                onPressed: () => Get.to(
                  () => const SignInScreenView(),
                  transition: Transition.fadeIn,
                ),
                key: UniqueKey(),
                backgroundOpacity: 0.1,
                height: 50,
                width: 371,
                child: Text(
                  'لدي حساب بالفعل',
                  style: TextStyle(
                    color: AppTheme.appTheme.colorScheme.onPrimary,
                    fontFamily: 'TITR',
                    fontSize: Responsive.width(28),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          )
        ],
      ),
    );
  }
}
