import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kokorico/core/helpers/enum.dart';

import '../../../../core/helpers/locator.dart';
import '../../../../core/helpers/shared_prefrence_helper.dart';
import '../../../../core/network/network_info.dart';

class AppState extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _isBusy = false;
  bool get isbusy => _isBusy;
  set isBusy(bool value) {
    if (value != _isBusy) {
      _isBusy = value;
      notifyListeners();
    }
  }

  late bool isFirstTime;
  late bool isModeAdmin;

  firstTime() async {
    isFirstTime = await getIt<SharedPreferenceHelper>().getFirstTimeStatus();
    if (isFirstTime) {
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

  setAdmiMode(Function rebirth) async {
    await getIt<SharedPreferenceHelper>().setModeAdminStatus(!isModeAdmin);
    notifyListeners();
    rebirth();
  }

  NetworkStatus _networkStatus = NetworkStatus.NOT_DETERMINED;
  NetworkStatus get networkStatus => _networkStatus;
  set networkStatus(NetworkStatus value) {
    if (value != _networkStatus) {
      _networkStatus = value;
      notifyListeners();
    }
  }

  Future<bool> checkNetwork() async {
    return await getIt<NetworkInfo>().isConnected;
  }
}
