import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kokorico/features/browsing/data/models/product_model.dart';
import 'package:kokorico/features/browsing/domain/entities/product.dart';
import '../../../../core/helpers/utility.dart';
import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required String uid,
    required String name,
    required String firstName,
    required String email,
    required String phoneNumber,
    String? imageUrl,
    String? bio,
    required String address,
    String? referenceAddress,
    String role = UserRole.USER,
    bool isVerified = false,
    List<Product> favorites = const [],
    List<Product> cart = const [],
  }) : super(
            uid: uid,
            name: name,
            firstName: firstName,
            email: email,
            phoneNumber: phoneNumber,
            imageUrl: imageUrl,
            bio: bio,
            address: address,
            referenceAddress: referenceAddress,
            role: role,
            isVerified: isVerified,
            favorites: favorites,
            cart: cart);

  factory AppUserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final documentSnapshot = snapshot.data();

    if (kDebugMode) {
      print("FROM FIRESTORE: $documentSnapshot");
    }
    return AppUserModel(
      uid: snapshot.id,
      name: documentSnapshot?['name'] ?? '',
      firstName: documentSnapshot?['firstName'] ?? '',
      email: documentSnapshot?['email'] ?? '',
      phoneNumber: documentSnapshot?['phoneNumber'] ?? '',
      imageUrl: documentSnapshot?['imageUrl'] ?? '',
      bio: documentSnapshot?['bio'] ?? '',
      address: documentSnapshot?['address'] ?? '',
      referenceAddress: documentSnapshot?['referenceAddress'] ?? '',
      role: documentSnapshot?['role'] ?? UserRole.USER,
      isVerified: documentSnapshot?['isVerified'] ?? false,
      favorites: (documentSnapshot?['favorites'] as Iterable)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      cart: (documentSnapshot?['cart'] as Iterable)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    var data = {
      "uid": uid,
      "name": name,
      "firstName": firstName,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "bio": bio,
      "address": address,
      "referenceAddress": referenceAddress,
      "role": role,
      "isVerified": isVerified,
      "favorites": favorites,
      "cart": cart,
    };

    print("TO FIRESTORE: ${data}");
    return data;
  }
}
