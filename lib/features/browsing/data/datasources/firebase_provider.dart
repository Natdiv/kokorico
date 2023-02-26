import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user_model.dart';

class FirestoreDataProvider {
  final FirebaseFirestore firebaseFirestore;

  FirestoreDataProvider({required this.firebaseFirestore});

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
}
