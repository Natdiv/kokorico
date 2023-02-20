import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kokorico/features/browsing/domain/entities/app_user.dart';

import '../../../../core/helpers/enum.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required String uid,
    required String name,
    required String firstName,
    required String email,
    required String phoneNumber,
    String? imageUrl,
    String? bio,
    String? address,
    String? referenceAddress,
    UserRole role = UserRole.USER,
    bool isVerified = false,
    List<String> favorites = const [],
    List<String> cart = const [],
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
    return AppUserModel(
      uid: snapshot.id,
      name: documentSnapshot?['name'],
      firstName: documentSnapshot?['firstName'],
      email: documentSnapshot?['email'],
      phoneNumber: documentSnapshot?['phoneNumber'],
      imageUrl: documentSnapshot?['imageUrl'],
      bio: documentSnapshot?['bio'],
      address: documentSnapshot?['address'],
      referenceAddress: documentSnapshot?['referenceAddress'],
      role: UserRole.values[documentSnapshot?['role']],
      isVerified: documentSnapshot?['isVerified'],
      favorites: List<String>.from(documentSnapshot?['favorites']),
      cart: List<String>.from(documentSnapshot?['cart']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
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
  }
}
