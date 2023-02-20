import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/helpers/locator.dart';
import '../../../../core/helpers/utility.dart';
import '../../data/data_layer/providers/firebase_provider.dart';
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

  // AppState get appState => getIt<AppState>();
  FirebaseProvider get firebaseProvider => getIt<FirebaseProvider>();

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
        await firebaseProvider.getProfileUser(uid: user!.uid);
        authStatus = AuthStatus.LOGGED_IN;
        userId = user!.uid;
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
}
