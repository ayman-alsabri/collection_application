import 'package:collection_application/app/views/auth/signup/signup_screen_controller.dart';
import 'package:collection_application/templates/containers/primary_curved_container.dart';
import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignupFirstTop extends StatelessWidget {
  const SignupFirstTop({super.key});

  static final List<Effect> effects = [
    const SlideEffect(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];

  @override
  Widget build(BuildContext context) {
    final SignupScreenController controller = Get.find();
    return PrimaryCurvedContainer(
      padding: const EdgeInsets.only(top: 24, bottom: 60, left: 24, right: 24),
      child: Obx(() {
        return Column(
          children: [
            CustomTextFieldWithName(
              onChanged: (p0) => controller.userName = p0.trim(),
              name: 'اسم المستخدم',
            ),
            const SizedBox(height: 8),
            (controller.useEmail.value
                    ? CustomTextFieldWithName(
                        onChanged: (p0) => controller.email = p0.trim(),
                        key: UniqueKey(),
                        name: 'الإيميل',
                        keyboardType: TextInputType.emailAddress,
                      )
                    : CustomTextFieldWithName(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        key: UniqueKey(),
                        onChanged: (p0) => controller.phoneNumber = p0.trim(),
                        name: 'رقم الهاتف',
                        keyboardType: TextInputType.phone,
                      ))
                .animate(
                    autoPlay: false,
                    effects: controller.fieldChangeEffects,
                    target: controller.animateText.value ? 1 : 0),
          ],
        );
      }),
    );
  }
}
