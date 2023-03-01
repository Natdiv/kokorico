import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/helpers/locator.dart';
import 'core/helpers/routes.dart';
import 'core/theme/theme.dart';
import 'features/browsing/presentation/state/app_state.dart';
import 'features/browsing/presentation/state/auth_state.dart';
import 'features/browsing/presentation/state/cart_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupDependencies();
  runApp(Phoenix(child: const KokoricoApp()));
}

class KokoricoApp extends StatelessWidget {
  const KokoricoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<CartState>(create: (_) => CartState())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kokorico',
        theme: AppTheme.getTheme().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: Routes.route(),
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        initialRoute: "/",
      ),
    );
  }
}
