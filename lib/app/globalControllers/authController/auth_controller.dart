import 'package:collection_application/app/data/messaging/firebase_messaging_controller.dart';
import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:collection_application/custom/dialog/waiting_dialog.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
// import 'package:collection_application/globalControllers/authController/validate.dart';
import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreHelper = FirestoreHelper();
  final _messaging = Get.find<FirebaseMessagingController>();

  Future<bool> signup(String userName, String email, String password) async {
    try {
      if (!await _checkInternetResult()) return false;
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreHelper.saveUserName(userName, email).timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw Error(),
          );
      await _messaging.subscribeTo();

      UserDataHelper().storeEmail(email);
      UserDataHelper().storeUserName(userName);
      return true;
    } catch (e) {
      WaitingDialog.hide();
      showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 7));

      await _firebaseAuth.signOut();

      return false;
    }
  }

  Future<bool> signin(String email, String password) async {
    try {
      if (!await _checkInternetResult()) return false;

      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userName = await _firestoreHelper.getUserName(email).timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw Error(),
          );
      await _messaging.subscribeTo();

      UserDataHelper().storeEmail(email);
      UserDataHelper().storeUserName(userName);
      return true;
    } catch (e) {
      WaitingDialog.hide();

      showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 7));
      await _firebaseAuth.signOut();
      return false;
    }
  }

  Future<bool> _checkInternetResult() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.google.com')).timeout(
                const Duration(seconds: 5),
                onTimeout: () => throw Error(),
              );
      if (response.statusCode != 200) {
        showCustomSnackBar('لا يوجد اتصال بالانترنت',
            "الرجاء الاتصال بالانترنت والمحاولة لاحقاَ");
        return false;
      }
      return true;
    } catch (e) {
      showCustomSnackBar('لا يوجد اتصال بالانترنت',
          "الرجاء الاتصال بالانترنت والمحاولة لاحقاَ");
      return false;
    }
  }
}
