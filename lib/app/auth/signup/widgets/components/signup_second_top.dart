import 'package:collection_application/app/auth/signup/signup_screen_controller.dart';
import 'package:collection_application/custom/containers/primary_curved_container.dart';
import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignupSecondTop extends StatelessWidget {
  const SignupSecondTop({super.key});

  static const List<Effect> effects = [
    SlideEffect(
        begin: Offset(0, -1.694),
        end: Offset(0, 0),
        curve: Cubic(0.6, 0.04, 0.58, 0.335),
        duration: Duration(milliseconds: 700))
  ];

  @override
  Widget build(BuildContext context) {
    final SignupScreenController controller = Get.find();
    return PrimaryCurvedContainer(
      padding: const EdgeInsets.only(top: 24, bottom: 60, left: 24, right: 24),
      child: Obx(
         () {
          return Column(
            children: [
              CustomTextFieldWithName(
                isPassword: true,
                onChanged: (p0) => controller.password = p0.trim(),
                name: 'كلمة المرور',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 8),
              CustomTextFieldWithName(
                isPassword: true,
                key: UniqueKey(),
                onChanged: (p0) => controller.passwordConfirmation = p0.trim(),
                name: 'توكيد كلمة المرور',
                keyboardType: TextInputType.visiblePassword,
              ).animate(
                  autoPlay: false,
                  effects: controller.fieldChangeEffects,
                  target: controller.animateText.value ? 1 : 0),
            ],
          );
        }
      ),
    );
  }
}
