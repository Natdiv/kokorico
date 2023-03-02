import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';

import '../../../../core/helpers/utility.dart';
import '../models/app_user_model.dart';
import '../models/orders_model.dart';

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
    // print("DATA SOURCES: getProducts()");
    final ref = firebaseFirestore.collection("products").withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel product, _) => product.toFirestore(),
        );
    final querySnapshot = await ref.get();
    final products = querySnapshot.docs.map((e) => e.data()).toList();
    // print("DATA SOURCES: PRODUCT => $products");
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

// Retrieve some products of the cart from firestore
  Future<List<ProductModel>> getSomeProducts(List<String> list) async {
    // print("DATA SOURCES: getProducts()");
    final ref = firebaseFirestore
        .collection("products")
        .withConverter(
          fromFirestore: ProductModel.fromFirestore,
          toFirestore: (ProductModel product, _) => product.toFirestore(),
        )
        .where('id', whereIn: list);
    final querySnapshot = await ref.get();
    final products = querySnapshot.docs.map((e) => e.data()).toList();
    return products;
  }

  // Update a cart user in the firestore
  Future<void> updateCart(
    String uid,
    List<Map<String, int>> cartRow,
  ) async {
    final ref = firebaseFirestore
        .collection("profiles")
        .withConverter(
          fromFirestore: AppUserModel.fromFirestore,
          toFirestore: (AppUserModel user, _) => user.toFirestore(),
        )
        .doc(uid);
    final querySnapshot = await ref.update({'cart': cartRow});

    if (kDebugMode) {
      print("Updated cart user: $ref");
    }
    return querySnapshot;
  }

  /// Create a new order in the firestore
  Future<void> createOrder(OrderModel orderModel) {
    final ref = firebaseFirestore.collection("orders").doc().withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel order, _) => order.toFirestore(),
        );

    orderModel.setId = ref.id;
    final querySnapshot = ref.set(orderModel);
    if (kDebugMode) {
      print("Added order: $ref");
    }
    return querySnapshot;
  }

  /// Retrieve all orders from firestore
  Future<List<OrderModel>> getOrders() async {
    final ref = firebaseFirestore.collection("orders").withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel order, _) => order.toFirestore(),
        );
    final querySnapshot = await ref.get();
    final orders = querySnapshot.docs.map((e) => e.data()).toList();
    // print("DATA SOURCES: PRODUCT => $products");
    return orders;
  }

  /// Retrieve all orders for today from firestore
  Future<List<OrderModel>> getOrdersForToday() async {
    final ref = firebaseFirestore
        .collection("orders")
        .withConverter(
          fromFirestore: OrderModel.fromFirestore,
          toFirestore: (OrderModel order, _) => order.toFirestore(),
        )
        .where('createdAt', isGreaterThanOrEqualTo: getFromTodayDate());
    final querySnapshot = await ref.get();
    final orders = querySnapshot.docs.map((e) => e.data()).toList();
    return orders;
  }
}
