import 'package:collection_application/app/auth/signup/signup_screen_controller.dart';
import 'package:collection_application/app/auth/signup/widgets/components/signup_first_bottom.dart';
import 'package:collection_application/app/auth/signup/widgets/components/signup_first_top.dart';
import 'package:collection_application/app/auth/signup/widgets/components/signup_second_top.dart';
import 'package:collection_application/app/auth/verification_code_container.dart';
import 'package:collection_application/templates/authBackground/auth_screen_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignUpScreenView extends StatelessWidget {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupScreenController());
    return Obx(() {
      return PopScope(
        canPop: controller.showFirstContainers.value,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.showSecondContainers.value) {
            controller.closeSecondPage();
          }
        },
        child: AuthScreenTemp(
          body: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SignupFirstTop().animate(
                        effects: SignupFirstTop.effects,
                        target: controller.showFirstContainers.value ? 1 : 0),
                    const SizedBox(
                      height: 16,
                    ),
                    const SignupFirstBottom().animate(
                        effects: SignupFirstBottom.effects,
                        target: controller.showFirstContainers.value ? 1 : 0),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SignupSecondTop().animate(
                        effects: SignupSecondTop.effects,
                        target: controller.showSecondContainers.value ? 1 : 0),
                    const SizedBox(
                      height: 16,
                    ),
                    VerificationCodeContainer(
                      onChanged: (p0) => controller.verificationCode = p0,
                      onTap:controller.signingUp.value?null: controller.signingup,
                    ).animate(
                        effects: controller.secondPageSecondaryContainerEffects,
                        target: controller.showSecondContainers.value ? 1 : 0),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
