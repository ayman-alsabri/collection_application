import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';

mixin Validate {
  bool validateSignupFirstPageFormat(
      String userName, String email, String phoneNumber, bool useEmail) {
    return (_validateUserNameFormat(userName) &&
        (useEmail
            ? _validateEmailFormat(email)
            : _validatePhoneNumberFormat(phoneNumber)));
  }

  bool validateSignupSecondPageFormat(
      String password, String passwordConfirmation, String verificationCode) {
    return (_validatePasswordFormat(password) &&
        _validatePasswordConfirmationFormat(password, passwordConfirmation) &&
        _validateverificationCodeFormat(verificationCode));
  }

  bool validateSigninFirstPageFormat(
      String email, String phoneNumber, String password, bool useEmail) {
    return ((useEmail
            ? _validateEmailFormat(email)
            : _validatePhoneNumberFormat(phoneNumber)) &&
        _validatePasswordFormat(password));
  }

  bool validateSigninSecondPageFormat(String verificationCode) {
    return _validateverificationCodeFormat(verificationCode);
  }

// local functions

  bool _validateEmailFormat(String email) {
    if (email.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك الإيميل فارغاً', "يرجى كتابة الإيميل أولاً");
      return false;
    }
    if (!email.endsWith('@gmail.com')) {
      showCustomSnackBar('تنسيق غير مقبول', "يرجى كتابة الإيميل بشكل صحيح");
      return false;
    }
    return true;
  }

  bool _validatePhoneNumberFormat(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك رقم الهاتف فارغاً', "يرجى كتابة رقم الهاتف أولاً");
      return false;
    }
    if (phoneNumber.length != 9) {
      showCustomSnackBar(
          'رقم هاتف غير مقبول', "يجب أن يتكون رقم الهاتف من 9 أرقام");
      return false;
    }
    if (RegExp(r'[^0-9]').hasMatch(phoneNumber)) {
      showCustomSnackBar(
          'رقم هاتف غير مقبول', "يجب أن يتكون رقم الهاتف من أرقام فقط");
      return false;
    }
    if (!RegExp(r'^(77|78|70|73|71)').hasMatch(phoneNumber)) {
      showCustomSnackBar(
          'رقم هاتف غير مقبول', "يجب ادخال رقم فعال لإحدى الشركات اليمنية");
      return false;
    }
    return true;
  }

  bool _validateUserNameFormat(String userName) {
    if (userName.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك اسم المستخدم فارغاً', "يرجى كتابة اسم المستخدم أولاً");
      return false;
    }
    if (userName.length < 3) {
      showCustomSnackBar(
          'اسم المستخدم قصير', "يرجى كتابة اسم المستخدم بشكل أطول");
      return false;
    }
    return true;
  }

  bool _validatePasswordFormat(String password) {
    if (password.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك كلمة المرور فارغة', "يرجى كتابة كلمة المرور أولاً");
      return false;
    }
    if (password.length < 8) {
      showCustomSnackBar('كلمة المرور قصيرة', "يرجى كتابة 8 رموز على الأقل");
      return false;
    }
    return true;
  }

  bool _validatePasswordConfirmationFormat(
      String password, String passwordConfirmation) {
    if (passwordConfirmation.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك حقل التوكيد فارغاً', "يرجى توكيد كلمة المرور");
      return false;
    }
    if (password != passwordConfirmation) {
      showCustomSnackBar(
          'كلمة المرور غير مطابقة', "يرجى توكيد كلمة المرور بالشكل الصحيح");
      return false;
    }
    return true;
  }

  bool _validateverificationCodeFormat(String verificationCode) {
    if (verificationCode.isEmpty) {
      showCustomSnackBar(
          'لايمكن ترك كود التوكيد فارغا', "يرجى كتابة كود التوكيد");
      return false;
    }
    if (verificationCode.length < 6) {
      showCustomSnackBar('كود التوكيد ناقص', "يرجى كتابة كود التوكيد كاملاً");
      return false;
    }
    if (verificationCode != '324927') {
      showCustomSnackBar('كود التوكيد خاطئ', "يرجى كتابة كود التوكيد الصحيح");
      return false;
    }
    return true;
  }
}
