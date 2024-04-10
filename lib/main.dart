import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/navbar/navbar.dart';
import 'package:parkingapp/features/main_page/presentation/main_page.dart';
import 'core/dependency_injection/injectable_config.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'features/theme/themes.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String environment = appFlavor.toString();
  configureDependencies(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
            routerConfig: GoRouter(routes: [
          ShellRoute(
              builder: (context, state, child) {
                return Scaffold(
                  body: child,
                  bottomNavigationBar: NavBar(
                    onRouteChanged: (String route) {
                      // context.goNamed(route); TODO: uncomment after giving valid routes
                    },
                  ),
                  extendBody: true,
                );
              },
              routes: [
                GoRoute(path: "/", builder: (context, state) => MainPage())
              ]),

        ]),
      title: 'ParkWise',
      theme: ThemeData(
        colorScheme: lightTheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkTheme,
        useMaterial3: true,
      ),
    );
  }
}
