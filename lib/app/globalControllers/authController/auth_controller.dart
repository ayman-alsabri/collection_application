import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
// import 'package:collection_application/globalControllers/authController/validate.dart';
import 'package:collection_application/app/data/firestore/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirestoreController _firestoreController = Get.find();

  Future<bool> signup(String userName, String email, String password) async {
    try {
      if (!await _checkInternetResult()) return false;
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreController.saveUserName(userName, email);
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
      return true;
    } catch (e) {
      await _firebaseAuth.signOut();
      showCustomSnackBar('خطأ', e.toString(),
          duration: const Duration(seconds: 3));
      return false;
    }
  }

  Future<bool> _checkInternetResult() async {
    final response = await http
        .get(Uri.parse('https://www.google.com'))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) {
      showCustomSnackBar('لا يوجد اتصال بالانترنت',
          "الرجاء الاتصال بالانترنت والمحاولة لاحقاَ");
      return false;
    }
    return true;
  }
}
