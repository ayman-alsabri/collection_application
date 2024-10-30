import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
// import 'package:collection_application/globalControllers/authController/validate.dart';
import 'package:collection_application/globalControllers/firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirestoreController _firestoreController = Get.find();

  Future<bool> signup(String userName, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreController.saveUserName(userName, email);
          return true;

    } catch (e) {
      await showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 3));
      return false;
    }
  }

  void authinticate(String username, String password) {
    // if (!Validate().validateCredintials(username, password)) {
    //   // Get.showSnackbar();
    //   return;
    // }
  }
}
