import 'package:collection_application/app/auth/signin/signin_screen_controller.dart';
import 'package:collection_application/custom/containers/primary_curved_container.dart';
import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SigninFirstTop extends StatelessWidget {
  static final List<Effect> effects = [
    const SlideEffect(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];
  const SigninFirstTop({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInScreenController controller = Get.find();
    return PrimaryCurvedContainer(
      padding: const EdgeInsets.only(top: 24, bottom: 60, left: 24, right: 24),
      child: Column(
        children: [
          Obx(() {
            return (controller.useEmail.value
                    ? CustomTextFieldWithName(
                        key: UniqueKey(),
                        name: 'الإيميل',
                        keyboardType: TextInputType.emailAddress,
                      )
                    : CustomTextFieldWithName(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        key: UniqueKey(),
                        name: 'رقم الهاتف',
                        keyboardType: TextInputType.phone,
                      ))
                .animate(
                    autoPlay: false,
                    effects: controller.fieldChangeEffects,
                    target: controller.animateText.value ? 1 : 0);
          }),
          const SizedBox(height: 8),
          const CustomTextFieldWithName(
            isPassword: true,
            name: 'كلمة المرور',
          ),
        ],
      ),
    );
  }
}
