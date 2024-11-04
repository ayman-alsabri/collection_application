import 'package:collection_application/app/views/auth/signin/components/signin_first_top.dart';
import 'package:collection_application/app/views/auth/signin/components/signin_first_bottom.dart';
import 'package:collection_application/app/views/auth/signin/signin_screen_controller.dart';
import 'package:collection_application/custom/containers/verification_code_container.dart';
import 'package:collection_application/templates/authBackground/auth_screen_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignInScreenView extends StatelessWidget {
  const SignInScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInScreenController());
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
            child: Obx(() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SigninFirstTop().animate(
                          effects: SigninFirstTop.effects,
                          target: controller.showFirstContainers.value ? 1 : 0),
                      const SizedBox(
                        height: 16,
                      ),
                      const SigninFirstBottom().animate(
                          effects: SigninFirstBottom.effects,
                          target: controller.showFirstContainers.value ? 1 : 0),
                    ],
                  ),
                  VerificationCodeContainer(
                    onChanged: (p0) => controller.verificationCode = p0,
                     onTap:controller.signingIn.value?null: controller.signingin
                  ).animate(
                      effects: controller.secondPageEffects,
                      target: controller.showSecondContainers.value ? 1 : 0),
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}
