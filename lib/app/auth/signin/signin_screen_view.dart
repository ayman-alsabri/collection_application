import 'package:collection_application/app/auth/signin/signin_screen_controller.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/custom/button/primary_white_button.dart';
import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name.dart';
import 'package:collection_application/custom/containers/primary_curved_container.dart';
import 'package:collection_application/custom/containers/secondary_curved_container.dart';
import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:collection_application/templates/authBackground/auth_screen_temp.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignInScreenView extends StatelessWidget {
  const SignInScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInScreenController());
    final responsive = Responsive.instanse;
    return AuthScreenTemp(
      onPressed: controller.toggleAnimation,
      body: Center(
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryCurvedContainer(
                padding: const EdgeInsets.only(
                    top: 24, bottom: 60, left: 24, right: 24),
                child: Column(
                  children: [
                    Obx(() {
                      return controller.useEmail.value
                          ? CustomTextFieldWithName(
                              key: UniqueKey(),
                              name: 'الإيميل',
                              keyboardType: TextInputType.emailAddress,
                            )
                          : CustomTextFieldWithName(
                              key: UniqueKey(),
                              name: 'رقم الهاتف',
                              keyboardType: TextInputType.phone,
                            );
                    }).animate(
                        autoPlay: false,
                        effects: controller.fieldChangeEffects,
                        target: controller.animateText.value ? 1 : 0),
                    SizedBox(height: 8),
                    CustomTextFieldWithName(
                      isPassword: true,
                      name: 'كلمة المرور',
                    ),
                  ],
                ),
              ).animate(
                  effects: controller.primaryContainerEffects,
                  target: controller.showContainers.value ? 1 : 0),
              const SizedBox(
                height: 16,
              ),
              SecondaryCurvedContainer(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 24, left: 24, right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryBlueButton(
                      height: 50,
                      width: 339,
                      child: Text(
                        'تسجل الدخول',
                        style: TextStyle(
                          fontFamily: 'TITR',
                          color: AppTheme.appTheme.colorScheme.onPrimary,
                          fontSize: responsive.height(28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryWhiteButton(
                      onPressed: controller.toggleMethod,
                      height: 50,
                      width: 339,
                      child: Text(
                        controller.useEmail.value ? 'رقم الهاتف' : 'الإيميل',
                        style: TextStyle(
                          fontFamily: 'TITR',
                          color: AppTheme.appTheme.colorScheme.secondary,
                          fontSize: responsive.width(28),
                        ),
                      ).animate(
                          autoPlay: false,
                          effects: controller.textChangeEffects,
                          target: controller.animateText.value ? 1 : 0),
                    )
                  ],
                ),
              ).animate(
                  effects: controller.secondaryContainerEffects,
                  target: controller.showContainers.value ? 1 : 0),
            ],
          );
        }),
      ),
    );
  }
}
