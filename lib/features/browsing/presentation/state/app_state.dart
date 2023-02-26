import 'package:flutter/foundation.dart';

import '../../../../core/helpers/locator.dart';
import '../../../../core/helpers/shared_prefrence_helper.dart';

class AppState extends ChangeNotifier {
  bool _isBusy = false;
  bool get isbusy => _isBusy;
  set isBusy(bool value) {
    if (value != _isBusy) {
      _isBusy = value;
      notifyListeners();
    }
  }

  late bool? isFirstTime;
  late bool isModeAdmin;

  firstTime() async {
    isFirstTime = await getIt<SharedPreferenceHelper>().getFirstTimeStatus();
    if (isFirstTime == null) {
      if (kDebugMode) {
        print("IS THE FIRST TIME");
      }
      await getIt<SharedPreferenceHelper>().setFirstTimeStatus(false);
      isFirstTime = true;
    } else {
      if (kDebugMode) {
        print("IS NOT THE FIRST TIME");
      }
      isFirstTime = false;
    }

    notifyListeners();
  }

  admiMode() async {
    isModeAdmin = await getIt<SharedPreferenceHelper>().getModeAdminStatus();
    if (isModeAdmin) {
      if (kDebugMode) {
        print("ADMIN MODE");
      }
    } else {
      if (kDebugMode) {
        print("USER MODE");
      }
    }
    notifyListeners();
  }
}
