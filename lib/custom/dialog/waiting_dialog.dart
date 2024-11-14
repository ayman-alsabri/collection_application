import 'dart:ui';

import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingDialog extends StatelessWidget {
  final String message;
  const WaitingDialog({super.key, required this.message});

  static bool _isShown = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                      fontFamily: 'SF MADA', fontSize: Responsive.width(25)),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.deviseWidth / 4),
                  child: LoadingAnimationWidget.discreteCircle(
                    color: Colors.white,
                    secondRingColor: bluegradientStartColor,
                    thirdRingColor: bluegradientEndColor,
                    size: Responsive.deviseWidth / 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void show([String message = 'يرجى الانتظار...']) {
    if (_isShown) return;
    Get.generalDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      transitionDuration: WaitingDialog.transitionDuration,
      transitionBuilder: WaitingDialog.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) => WaitingDialog(
        message: message,
      ),
    );
    _isShown = true;
  }

  static void hide() {
    if (!_isShown) return;
    Get.closeAllSnackbars();
    Get.back(canPop: true);
    _isShown = false;
  }

  static const transitionDuration = Duration(milliseconds: 300);
  static Widget transitionBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );
    final scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      ),
    );

    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }
}
