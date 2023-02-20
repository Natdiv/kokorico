import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/app_user_model.dart';

class FirebaseProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<AppUserModel?> getProfileUser({required String uid}) async {
    final ref =
        _firebaseFirestore.collection("accounts").doc(uid).withConverter(
              fromFirestore: AppUserModel.fromFirestore,
              toFirestore: (AppUserModel user, _) => user.toFirestore(),
            );
    final docSnap = await ref.get();
    final user = docSnap.data();
    return user;
  }
}
