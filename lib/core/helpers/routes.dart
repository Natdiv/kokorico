import 'package:flutter/material.dart';
import '../../features/browsing/presentation/pages/auth/signin.dart';
import '../../features/browsing/presentation/pages/auth/signup.dart';
import '../../features/browsing/presentation/pages/auth/sms_code.dart';
import '../../features/browsing/presentation/pages/users_ui/cart.dart';
import '../../features/browsing/presentation/pages/users_ui/delivery.dart';
import '../../features/browsing/presentation/pages/users_ui/home.dart';
import '../../features/browsing/presentation/pages/users_ui/notifications.dart';
import '../../features/browsing/presentation/pages/users_ui/profil.dart';
import '../../features/browsing/presentation/pages/users_ui/must_be_connected.dart';
import 'package:provider/provider.dart';
import '../../features/browsing/presentation/pages/splash.dart';
import '../../features/browsing/presentation/state/auth_state.dart';
import 'enum.dart';

class Routes {
  static dynamic route() {
    return {
      'SplashPage': (BuildContext context) => const SplashScreen(),
    };
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final pathName = settings.name;
    switch (pathName) {
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/cart':
        return MaterialPageRoute(
          builder: (context) => const CartPage(),
        );
      case '/notifications':
        return MaterialPageRoute(
          builder: (context) => (mustBeLoggedIn(context))
              ? const NotificationsPage()
              : const MustBeConnectedPage(),
        );
      case '/delivery':
        return MaterialPageRoute(
          builder: (context) => (mustBeLoggedIn(context))
              ? const DeliveryPage()
              : const MustBeConnectedPage(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (context) => (mustBeLoggedIn(context))
              ? const ProfilePage()
              : const MustBeConnectedPage(),
        );
      case '/signin':
        return MaterialPageRoute(
          builder: (context) => const SigninPage(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => const SignupPage(),
        );

      default:
        return null;
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }

  static bool mustBeLoggedIn(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    return state.authStatus == AuthStatus.LOGGED_IN;
  }

  static void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
