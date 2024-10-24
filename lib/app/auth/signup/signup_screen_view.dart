import 'package:collection_application/app/auth/signup/signup_screen_controller.dart';
import 'package:collection_application/custom/buttona/primary_blue_button.dart';
import 'package:collection_application/custom/buttona/primary_white_button.dart';
import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name.dart';
import 'package:collection_application/custom/containers/primary_curved_container.dart';
import 'package:collection_application/custom/containers/secondary_curved_container.dart';
import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:collection_application/templates/authBackground/auth_screen_temp.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignUpScreenView extends StatelessWidget {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupScreenController());
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
                padding:
                    const EdgeInsets.only(top: 24, bottom: 60, left: 24, right: 24),
                child: Column(
                  children: [
                    const CustomTextFieldWithName(
                      name: 'اسم المستخدم',
                    ),
                    const SizedBox(height: 8),
                    Obx(
                       () {
                        return CustomTextFieldWithName(
                          name:controller.useEmail.value? 'الإيميل':'رقم الهاتف',
                          keyboardType: controller.useEmail.value? TextInputType.emailAddress:TextInputType.phone,
                        );
                      }
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
                        'انشاء حساب',
                        style: TextStyle(
                          fontFamily: 'TITR',
                          color: AppTheme.appTheme.colorScheme.onPrimary,
                          fontSize: responsive.height(28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryWhiteButton(onPressed: controller.toggleMethod,
                      height: 50,
                      width: 339,
                      child: Text(
                       controller.useEmail.value? 'رقم الهاتف':'الإيميل',
                        style: TextStyle(
                          fontFamily: 'TITR',
                          color: AppTheme.appTheme.colorScheme.secondary,
                          fontSize: responsive.width(28),
                        ),
                      ),
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
