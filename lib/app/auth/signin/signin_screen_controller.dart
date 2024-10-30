import 'package:collection_application/app/auth/signin/components/signin_first_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignInScreenController extends GetxController {
  final showFirstContainers = true.obs;
  final showSecondContainers = false.obs;
  final useEmail = false.obs;
  final animateText = false.obs;

  String verificationCode = '';

  final List<Effect> secondPageEffects = [
    const SlideEffect(
        begin: Offset(0, 3),
        end: Offset(0, 0),
        curve: Cubic(0.6, 0.04, 0.58, 0.335),
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

  // void toggleAnimation() {
  //   showContainers.value = !showContainers.value;
  // }

    void openSecondPage() async {
    showFirstContainers.value = false;
    await Future.delayed(Duration(milliseconds: SigninFirstTop.effects.first.duration!.inMilliseconds-200));
    showSecondContainers.value = true;
  }
  void closeSecondPage() async {
    showSecondContainers.value = false;
    await Future.delayed(Duration(milliseconds: SigninFirstTop.effects.first.duration!.inMilliseconds-200));
    showFirstContainers.value = true;
  }

  void toggleMethod() async {
    animateText.value = true;
    await Future.delayed(textChangeEffects.first.duration!);
    useEmail.value = !useEmail.value;
    animateText.value = false;
  }
}
