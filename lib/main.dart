import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/navbar/navbar.dart';
import 'package:parkingapp/features/main_page/presentation/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/dependency_injection/injectable_config.dart';
import 'package:flutter/services.dart';

import 'features/theme/themes.dart';
//
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter's binding is initialized

  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('currentlyPayingParking', 'AB1234CD');
  // Check if there is a value stored in 'currentlyPayingParking'.
  final String? currentlyPayingParking = prefs.getString('currentlyPayingParking');

  String environment = appFlavor.toString();
  configureDependencies(environment);
  runApp(MyApp());


}

class MyApp extends StatelessWidget {


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

