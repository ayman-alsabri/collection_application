import 'package:collection_application/app/data/stored/userData/user_data_helper.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
// import 'package:collection_application/globalControllers/authController/validate.dart';
import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreHelper = FirestoreHelper();

  Future<bool> signup(String userName, String email, String password) async {
    try {
      if (!await _checkInternetResult()) return false;
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreHelper.saveUserName(userName, email);

      UserDataHelper().storeEmail(email);
      UserDataHelper().storeUserName(userName);
      return true;
    } catch (e) {
      await _firebaseAuth.signOut();
      showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 3));

      return false;
    }
  }

  Future<bool> signin(String email, String password) async {
    try {
      if (!await _checkInternetResult()) return false;

      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userName = await _firestoreHelper.getUserName(email);

      UserDataHelper().storeEmail(email);
      UserDataHelper().storeUserName(userName);
      return true;
    } catch (e) {
      await _firebaseAuth.signOut();
      showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 3));
      return false;
    }
  }

  Future<bool> _checkInternetResult() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) {
        showCustomSnackBar('لا يوجد اتصال بالانترنت',
            "الرجاء الاتصال بالانترنت والمحاولة لاحقاَ");
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
