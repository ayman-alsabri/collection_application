import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveUserName(String userName, String email) async {
   await _firestore.collection('users').add({'userName': userName, 'email': email});
  }
}
