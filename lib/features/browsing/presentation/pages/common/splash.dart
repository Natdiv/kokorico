import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/theme/colors.dart';
import '../../state/cart_state.dart';
import '../admin_ui/dashboard.dart';
import 'must_be_connected.dart';
import 'no_internet.dart';
import 'welcome.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/enum.dart';
import '../../state/auth_state.dart';
import '../users_ui/home.dart';

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
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      var state = Provider.of<AuthState>(context, listen: false);
      var cartState = Provider.of<CartState>(context, listen: false);
      if (!(await state.checkNetwork())) {
        state.hasConnexion = false;
        return;
      }
      state.hasConnexion = true;
      state.firstTime();
      state.admiMode();
      final user = await state.getCurrentUser();
      if (user != null &&
          state.appUser != null &&
          state.authStatus == AuthStatus.LOGGED_IN) {
        cartState.init(state.appUser!.cart, state.appUser!.favorites);
      }
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);

    if (!state.hasConnexion) {
      return const NoInternetConnexion();
    }

    if (state.authStatus == AuthStatus.NOT_DETERMINED) {
      return _body();
    } else if (state.isFirstTime) {
      return const WelcomePage();
    } else if (state.authStatus == AuthStatus.NOT_LOGGED_IN &&
        state.isModeAdmin) {
      return const MustBeConnectedPage();
    } else if (state.authStatus == AuthStatus.LOGGED_IN && state.isModeAdmin) {
      return const DashboardPage();
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
