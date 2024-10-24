import 'package:collection_application/globalControllers/authController/validate.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool _isAuth = false.obs;

  get isAuth => _isAuth;

  void authinticate(String username, String password) {
    if (!Validate().validateCredintials(username, password)) {
      // Get.showSnackbar();
      return;
    }

    _isAuth.value = true;
  }
}
