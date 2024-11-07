import 'package:collection_application/app/views/auth/signup/signup_screen_controller.dart';
import 'package:collection_application/app/views/auth/signup/widgets/qr_code_handler_view.dart';
import 'package:collection_application/custom/button/primary_blue_button.dart';
import 'package:collection_application/custom/button/primary_white_button.dart';
import 'package:collection_application/templates/containers/secondary_curved_container.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignupFirstBottom extends StatelessWidget {
  const SignupFirstBottom({super.key});
  static final List<Effect> effects = [
    const SlideEffect(
        begin: Offset(1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];

  @override
  Widget build(BuildContext context) {
    final SignupScreenController controller = Get.find();
    return SecondaryCurvedContainer(
      padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const QrCodeHandlerView(),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                return PrimaryBlueButton(
                  onPressed: controller.showFirstContainers.value
                      ? controller.openSecondPage
                      : null,
                  height: 50,
                  width: 202,
                  text: 'انشاء حساب',
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return PrimaryWhiteButton(
                  onPressed: controller.showFirstContainers.value
                      ? controller.toggleMethod
                      : null,
                  height: 50,
                  width: 202,
                  child: Text(
                    controller.useEmail.value ? 'رقم الهاتف' : 'الإيميل',
                    style: TextStyle(
                      fontFamily: 'TITR',
                      color: AppTheme.appTheme.colorScheme.secondary,
                      fontSize: Responsive.width(28),
                    ),
                  ).animate(
                      autoPlay: false,
                      effects: controller.textChangeEffects,
                      target: controller.animateText.value ? 1 : 0),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
