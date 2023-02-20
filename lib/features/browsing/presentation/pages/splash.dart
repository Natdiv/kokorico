import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/shared_prefrence_helper.dart';
import '../../../../core/theme/colors.dart';
import 'users_ui/welcome.dart';
import '../state/app_state.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/enum.dart';
import '../../../../core/helpers/locator.dart';
import '../state/auth_state.dart';
import 'users_ui/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  /// Check if current app is updated app or not
  /// If app is not updated then redirect user to update app screen
  void timer() async {
    // final isAppUpdated = await _checkAppVersion();
    // if (isAppUpdated) {
    // cprint("App is updated");
    Future.delayed(const Duration(seconds: 1)).then((_) {
      var state = Provider.of<AuthState>(context, listen: false);
      state.firstTime();
      state.getCurrentUser();
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    if (state.authStatus == AuthStatus.NOT_DETERMINED) {
      return _body();
    }
    if (state.authStatus == AuthStatus.NOT_LOGGED_IN) {
      if (state.isFirstTime!) {
        return const WelcomePage();
      } else {
        return const HomePage();
      }
    } else {
      return const HomePage();
    }
  }

  Widget _body() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo/logo.svg',
                width: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                color: AppColors.primaryColorDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
