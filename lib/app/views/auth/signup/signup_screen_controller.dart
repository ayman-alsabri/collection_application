import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:collection_application/app/data/stored/databases/database_helper.dart';
import 'package:collection_application/app/views/auth/signup/components/signup_first_top.dart';
import 'package:collection_application/custom/dialog/dialog_with_confirmation_only.dart';
import 'package:collection_application/templates/dialog/general_dialog.dart';
import 'package:collection_application/custom/dialog/waiting_dialog.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:collection_application/app/globalControllers/authController/auth_controller.dart';
import 'package:collection_application/app/globalControllers/authController/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SignupScreenController extends GetxController with Validate {
  final AuthController _authcontroller = Get.find();

  final showFirstContainers = true.obs;
  final showSecondContainers = false.obs;
  final useEmail = true.obs;
  final animateText = false.obs;
  final signingUp = false.obs;

  String email = '';
  String phoneNumber = '';
  String userName = '';
  String password = '';
  String passwordConfirmation = '';
  String verificationCode = '';

  final List<Effect> secondPageSecondaryContainerEffects = [
    const SlideEffect(
        begin: Offset(0, 2),
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

  void openSecondPage() async {
    if (!validateSignupFirstPageFormat(
        userName, email, phoneNumber, useEmail.value)) return;
    if (!useEmail.value) {
      toggleMethod();
      return showCustomSnackBar(
          'هذه الميزة غير متوفرة', 'الرجاء استخدام الإيميل');
    }
    final bool? ok = await Get.generalDialog(
      transitionDuration: GeneralDialog.transitionDuration,
      transitionBuilder: GeneralDialog.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DialogWithConfirmationOnly(
        confirmText: "موافق",
        cancelText: "تعديل",
        onConfirmed: () async => Get.back(result: true),
        onCanceled: () => Get.back(result: false),
        title: 'هل انت متأكد من الإيميل',
        subtitle: email,
      ),
    );
    if (!(ok ?? false)) return;

    showFirstContainers.value = false;
    await Future.delayed(Duration(
        milliseconds:
            SignupFirstTop.effects.first.duration!.inMilliseconds - 200));
    showSecondContainers.value = true;
  }

  void closeSecondPage() async {
    final bool? ok = await Get.generalDialog(
      transitionDuration: GeneralDialog.transitionDuration,
      transitionBuilder: GeneralDialog.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) =>
          DialogWithConfirmationOnly(
        confirmText: "نعم",
        cancelText: "لا",
        onConfirmed: () async => Get.back(result: true),
        onCanceled: () => Get.back(result: false),
        title: 'هل تريد التراجع',
      ),
    );
    if (!(ok ?? false)) return;

    showSecondContainers.value = false;
    await Future.delayed(Duration(
        milliseconds:
            SignupFirstTop.effects.first.duration!.inMilliseconds - 200));
    showFirstContainers.value = true;
  }

  void toggleMethod() async {
    animateText.value = true;
    if (useEmail.value) {
      email = '';
    } else {
      phoneNumber = '';
    }
    await Future.delayed(textChangeEffects.first.duration!);
    useEmail.value = !useEmail.value;
    animateText.value = false;
  }

  Future<void> signingup() async {
    if (!(validateSignupSecondPageFormat(
        password, passwordConfirmation, verificationCode))) return;

    signingUp.value = true;
    WaitingDialog.show();

    final signupResult =
        await _authcontroller.signup(userName, email, password);
    if (signupResult) {
      showSecondContainers.value = false;
      await Future.delayed(const Duration(milliseconds: 150));
      WaitingDialog.hide();
      WaitingDialog.show('جار تحميل البيانات');
      await DatabaseHelper().storeFoods(await FirestoreHelper().getFoods());
      await DatabaseHelper().storeUnits(await FirestoreHelper().getUnits());
      await DatabaseHelper().storeIngrediants(await FirestoreHelper().getIngrediants());
      await DatabaseHelper()
          .storeProducts(await FirestoreHelper().getProducts());
      WaitingDialog.hide();
      Get.back(canPop: true, closeOverlays: true);
      return;
    }
    signingUp.value = false;
  }
}
