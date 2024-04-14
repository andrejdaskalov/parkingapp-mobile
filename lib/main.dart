import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/navbar/navbar.dart';
import 'package:parkingapp/features/main_page/presentation/main_page.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:parkingapp/features/parking_payment/presentation/payment_status_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/dependency_injection/injectable_config.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter's binding is initialized
  String environment = appFlavor.toString();
  configureDependencies(environment);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<PaymentBloc>(),
      child: MaterialApp.router(
              routerConfig: GoRouter(routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
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
                  GoRoute(path: "/", builder: (context, state) => MainPage()),
                  GoRoute(path: "/payment-details", builder: (context, state) => ParkingPaymentDetails()),
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
      ),
    );
  }
}
