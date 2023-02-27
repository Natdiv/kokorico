import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kokorico/core/usecases/usecase.dart';
import 'package:kokorico/features/browsing/domain/usescases/create_user_profile.dart';
import 'package:kokorico/features/browsing/domain/usescases/get_user_profile.dart';
import 'package:kokorico/features/browsing/presentation/pages/auth/sms_code.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helpers/locator.dart';
import '../../../../core/helpers/utility.dart';
import '../../data/models/app_user_model.dart';

import '../../../../core/helpers/enum.dart';
import '../../../../core/helpers/shared_prefrence_helper.dart';

import 'app_state.dart';

class AuthState extends AppState {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  User? user;
  late String userId;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AppUserModel? _appUser;

  AppUserModel? get appUser => _appUser;

  final GetUserProfile _getUserProfile = getIt<GetUserProfile>();
  final CreateUserProfile _createUserProfile = getIt<CreateUserProfile>();

  // AppState get appState => getIt<AppState>();

  /// When user entering SMS code
  // bool _isCodeSent = false;
  // bool get isCodeSent => _isCodeSent;
  // set isCodeSent(bool value) {
  //   if (value != _isCodeSent) {
  //     _isCodeSent = value;
  //     notifyListeners();
  //   }
  // }

  /// The verification ID
  // late String _verificationId;
  // String get verificationId => _verificationId;
  // set verificationId(String value) {
  //   if (value != _verificationId) {
  //     _verificationId = value;
  //     notifyListeners();
  //   }
  // }

  /// Authentification error
  // late String _error;
  // String get errorAuth => _error;
  // set errorAuth(value) {
  //   if (value != _error) {
  //     _error = value;
  //     notifyListeners();
  //   }
  // }

  /// Logout from device
  void logoutCallback() async {
    authStatus = AuthStatus.NOT_LOGGED_IN;
    userId = '';
    _appUser = null;
    user = null;
    await _firebaseAuth.signOut();
    notifyListeners();
    await getIt<SharedPreferenceHelper>().clearPreferenceValues();
  }

  /// Fetch current user profile
  Future<User?> getCurrentUser() async {
    try {
      isBusy = true;
      Utility.logEvent('get_currentUSer', parameter: {});
      user = _firebaseAuth.currentUser;
      if (user != null) {
        (await _getUserProfile(Params(id: user!.uid))).fold((failure) {
          var message = failure.props.first;
          print(
              'GET USER PROFILE FAILURE: ${message ?? 'Une erreur est survenue'}');
          isBusy = false;
          return null;
        }, (user_) {
          print('GET USER PROFILE SUCCESS');
          _appUser = user_ as AppUserModel?;
          authStatus = AuthStatus.LOGGED_IN;
          userId = user!.uid;
        });
      } else {
        authStatus = AuthStatus.NOT_LOGGED_IN;
      }
      isBusy = false;
      return user;
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getCurrentUser');
      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }

  /// Create a user profile in firestore
  Future<void> createProfileUser(AppUserModel appUserModel) {
    if (kDebugMode) {
      print('CREATING NEW USER');
    }
    return _createUserProfile(appUserModel);
  }

  Future<void> verifyPhoneNumber(BuildContext context, String phoneNumber,
      {bool isNewUser = false,
      String? firstName,
      String? name,
      String? email,
      String? adresse,
      String? reference,
      Function()? pop}) async {
    try {
      isBusy = true;
      Utility.logEvent('verify_phone_number', parameter: {});
      return _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (kDebugMode) {
            print('V_COMPLETED********************************');
          }
          await _firebaseAuth.signInWithCredential(credential);
          // await getCurrentUser();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            cprint('The provided phone number is not valid.');
          }

          cprint('Une erreur est survenue');
          if (kDebugMode) {
            print(e.message);
          }
          //errorAuth = 'Une erreur est survenue';
          isBusy = false;
          // isCodeSent = false;
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          // isCodeSent = true;
          isBusy = false;

          String smsCode = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            if (kDebugMode) {
              print('GOTO SMS PAGE');
            }
            return SmsCodePage();
          }));

          isBusy = true;

          if (kDebugMode) {
            print(smsCode);
            print('CODE SENT');
          }

          // // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // // Sign the user in (or link) with the credential
          await _firebaseAuth.signInWithCredential(credential);

          if (isNewUser) {
            user = _firebaseAuth.currentUser;
            if (kDebugMode) {
              print('USER: $user');
            }
            var appUserModel = AppUserModel(
                uid: user!.uid,
                name: name!,
                firstName: firstName!,
                email: email!,
                phoneNumber: phoneNumber,
                address: adresse!,
                referenceAddress: reference);
            if (kDebugMode) {
              print('AppUserModel: $appUserModel');
            }
            await createProfileUser(appUserModel);
          }

          if (await getCurrentUser() != null) {
            pop!();
          } else {}

          if (kDebugMode) {
            print('CURRENT_USER: $_appUser');
          }

          isBusy = false;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (kDebugMode) {
            print('RETRIEVAL TIMEOUT');
          }
          // isCodeSent = true;
        },
      );
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'verifyPhoneNumber');
      if (kDebugMode) {
        print('FAILURE AUTH');
      }
    }
  }

  // signinWithPhone(String verificationId, String smsCode) async {
  //   isBusy = true;
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: smsCode);
  //     await _firebaseAuth.signInWithCredential(credential);
  //     isBusy = false;
  //     // Get.offAll(() => MainPage());
  //   } catch (e) {
  //     print(e);
  //     isBusy = false;
  //   }
  // }
}
