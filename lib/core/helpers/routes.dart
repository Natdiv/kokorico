import 'package:flutter/material.dart';
import 'package:kokorico/features/browsing/presentation/pages/users_ui/home.dart';
import '../../features/browsing/presentation/pages/splash.dart';

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
}
