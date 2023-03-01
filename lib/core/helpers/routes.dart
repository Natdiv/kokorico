import 'package:flutter/material.dart';
import '../../features/browsing/presentation/pages/admin_ui/all_orders.dart';
import '../../features/browsing/presentation/pages/admin_ui/dashboard.dart';
import '../../features/browsing/presentation/pages/admin_ui/new_product.dart';
import '../../features/browsing/presentation/pages/admin_ui/payments-received.dart';
import '../../features/browsing/presentation/pages/admin_ui/product_list.dart';
import '../../features/browsing/presentation/pages/auth/signin.dart';
import '../../features/browsing/presentation/pages/auth/signup.dart';
import '../../features/browsing/presentation/pages/common/access_denied_page.dart';
import '../../features/browsing/presentation/pages/users_ui/cart.dart';
import '../../features/browsing/presentation/pages/users_ui/delivery.dart';
import '../../features/browsing/presentation/pages/users_ui/home.dart';
import '../../features/browsing/presentation/pages/users_ui/notifications.dart';
import '../../features/browsing/presentation/pages/users_ui/product_details.dart';
import '../../features/browsing/presentation/pages/users_ui/profil.dart';
import '../../features/browsing/presentation/pages/common/must_be_connected.dart';
import 'package:provider/provider.dart';
import '../../features/browsing/presentation/pages/common/splash.dart';
import '../../features/browsing/presentation/state/auth_state.dart';
import 'enum.dart';
import 'utility.dart';

class Routes {
  static dynamic route() {
    return {
      '/': (BuildContext context) => const SplashScreen(),
    };
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final pathName = settings.name;
    switch (pathName) {
      // Setup admin routes
      case '/dashboard':
        return MaterialPageRoute(
          builder: (context) => (mustBeAdminUser(context))
              ? const DashboardPage()
              : const AccessDeniedPage(),
        );

      case '/new-product':
        return MaterialPageRoute(
          builder: (context) => (mustBeAdminUser(context))
              ? const NewProductPage()
              : const AccessDeniedPage(),
        );
      case '/all-products':
        return MaterialPageRoute(
          builder: (context) => (mustBeAdminUser(context))
              ? const ProductListPage()
              : const AccessDeniedPage(),
        );
      case '/all-orders':
        return MaterialPageRoute(
          builder: (context) => (mustBeAdminUser(context))
              ? const AllOrdersPage()
              : const AccessDeniedPage(),
        );
      case '/payments-received':
        return MaterialPageRoute(
          builder: (context) => (mustBeAdminUser(context))
              ? const PaymentReceivedPage()
              : const AccessDeniedPage(),
        );

      // Setup user routes
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/product':
        return MaterialPageRoute(
          builder: (context) => const ProductDetailsPage(),
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
    var state = Provider.of<AuthState>(context);
    return state.authStatus == AuthStatus.LOGGED_IN;
  }

  static bool mustBeAdminUser(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return (state.authStatus == AuthStatus.LOGGED_IN &&
        state.appUser!.role == UserRole.ADMIN);
  }

  static void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void pushReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
