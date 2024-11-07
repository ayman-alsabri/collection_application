import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection_application/app/data/firestore/firesstore_helper_mixin.dart';




class FirestoreHelper with FirestoreHelperMixin {
  factory FirestoreHelper() => _instance;
  static final _instance = FirestoreHelper._intrnal();
  FirestoreHelper._intrnal();
  static final firestore = FirebaseFirestore.instance;

  Future<void> saveUserName(String userName, String email) async {
    await firestore.collection('users').doc(email).set({
      'userName': userName,
    });
  }

  Future<String> getUserName(String email) async {
    return (await firestore.collection('users').doc(email).get())
        .data()?['userName'];
  }
}
