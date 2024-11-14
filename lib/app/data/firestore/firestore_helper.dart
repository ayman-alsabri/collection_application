import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection_application/app/data/firestore/firestore_helper_mixin.dart';

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

  Future<List<Map<String, dynamic>>> getFoods() async {
    final foods = <Map<String, dynamic>>[];
    final docs = (await firestore.collection('Food').get()).docs;

    for (var doc in docs) {
      foods.add({'id': int.parse(doc.id), ...doc.data()});
    }
    return foods;
  }

  Future<List<Map<String, dynamic>>> getUnits() async {
    final units = <Map<String, dynamic>>[];
    final docs = (await firestore.collection('Unit').get()).docs;

    for (var doc in docs) {
      units.add({'id': int.parse(doc.id), ...doc.data()});
    }
    return units;
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final products = <Map<String, dynamic>>[];
    final docs = (await firestore.collection('Product').get()).docs;

    for (var doc in docs) {
      products.add({'id': int.parse(doc.id), ...doc.data()});
    }
    return products;
  }

  Future<List<Map<String, dynamic>>> getIngrediants() async {
    final products = <Map<String, dynamic>>[];
    final docs = (await firestore.collection('Ingrediant').get()).docs;

    for (var doc in docs) {
      products.add(doc.data());
    }
    return products;
  }

  Future<int> getPoints(String email) async {
    return (await firestore.collection('users').doc(email).get())
        .data()?['points'];
  }
}
