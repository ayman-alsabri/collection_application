import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignupScreenController extends GetxController {
  final showContainers = true.obs;
  final useEmail = false.obs;
  

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
      duration: Duration(milliseconds: 200),
      begin: 0,
      end: 1,
    ),
    const FadeEffect(
        duration: Duration(milliseconds: 200),
        delay: Duration(milliseconds: 200),
        begin: 1,
        end: 0)
  ];

  void toggleAnimation() {
    showContainers.value = !showContainers.value;
  }

  void toggleMethod() {
    useEmail.value = !useEmail.value;
  }
}
