import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignInScreenController extends GetxController {
  final showContainers = true.obs;
  final useEmail = false.obs;
  final animateText = false.obs;

  final List<Effect> primaryContainerEffects = [
    const SlideEffect(
        begin: Offset(-1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];
  final List<Effect> secondaryContainerEffects = [
    const SlideEffect(
        begin: Offset(1, 0),
        end: Offset(0, 0),
        curve: Cubic(0.075, 0.4, 0.165, 1.0),
        duration: Duration(milliseconds: 700))
  ];
  final List<Effect> textChangeEffects = [
    const FadeEffect(
      duration: Duration(milliseconds: 250),
      begin: 1,
      end: 0,
    ),
  ];
  final List<Effect> fieldChangeEffects = [
    const BlurEffect(
      duration: Duration(milliseconds: 250),
      begin: Offset(0, 0),
      end: Offset(0, 2.5),
    ),
  ];

  void toggleAnimation() {
    showContainers.value = !showContainers.value;
  }

  void toggleMethod() async {
    animateText.value = true;
    await Future.delayed(textChangeEffects.first.duration!);
    useEmail.value = !useEmail.value;
    animateText.value = false;
  }
}
