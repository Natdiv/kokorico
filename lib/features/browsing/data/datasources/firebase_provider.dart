import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';

import '../models/app_user_model.dart';

class FirestoreDataProvider {
  final FirebaseFirestore firebaseFirestore;

  FirestoreDataProvider({required this.firebaseFirestore});

// Retrieve a user from firestore
  Future<AppUserModel?> getProfileUser({required String uid}) async {
    print("DATA SOURCES: getProfileUser(uid: $uid");
    final ref = firebaseFirestore.collection("profiles").doc(uid).withConverter(
          fromFirestore: AppUserModel.fromFirestore,
          toFirestore: (AppUserModel user, _) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    final user = docSnap.data();
    print("DATA SOURCES: USER => ${user}");
    print("FIRESTORE: => ${firebaseFirestore.app.name}");
    return user;
  }

  // Create a new user in firestore
  Future<void> createUser(AppUserModel userModel) async {
    print("DATA SOURCES: createUser(user: $userModel");
    final ref = firebaseFirestore
        .collection("profiles")
        .doc(userModel.uid)
        .withConverter(
          fromFirestore: AppUserModel.fromFirestore,
          toFirestore: (AppUserModel _user, _) => _user.toFirestore(),
        );

    final querySnapshot = await ref.set(userModel);
    if (kDebugMode) {
      print("Added client: $ref");
    }
    return querySnapshot;
  }

  // Retrieve all products from firestore
  Future<List<ProductModel>> getProducts() async {
    print("DATA SOURCES: getProducts()");
    final ref = firebaseFirestore.collection("products").withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel product, _) => product.toFirestore(),
        );
    final querySnapshot = await ref.get();
    final products = querySnapshot.docs.map((e) => e.data()).toList();
    print("DATA SOURCES: PRODUCT => $products");
    return products;
  }

// Create a new product in the firestore
  Future<void> createProduct(ProductModel product) async {
    if (kDebugMode) {
      print("DATA SOURCES: createProduct(user: $product");
    }
    final ref = firebaseFirestore.collection("products").doc().withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel _product, _) => _product.toFirestore(),
        );

    product.id = ref.id;
    final querySnapshot = await ref.set(product);
    if (kDebugMode) {
      print("Added product: $ref");
    }
    return querySnapshot;
  }
}
