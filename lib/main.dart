import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/navbar/navbar.dart';
import 'package:parkingapp/features/main_page/presentation/main_page.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:parkingapp/features/parking_payment/presentation/payment_status_screen.dart';
import 'package:parkingapp/features/profile_page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:parkingapp/features/main_page/presentation/bloc/main_page_bloc.dart';

import 'core/dependency_injection/injectable_config.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/repository/parking_repository.dart';
import 'firebase_options.dart';
import 'features/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter's binding is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String environment = appFlavor.toString();
  configureDependencies(environment);
  runApp(MyApp(parkingRepository: getIt.get<ParkingRepository>()));
}

class MyApp extends StatefulWidget {
  final ParkingRepository parkingRepository;

  MyApp({required this.parkingRepository, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => getIt.get<PaymentBloc>(), // Provide the *same* PaymentBloc to the entire app
      providers: [
        BlocProvider<PaymentBloc>(
          create: (context) => getIt.get<PaymentBloc>(),
        ),
        BlocProvider<MainPageBloc>(
          create: (context) {
            var instance = getIt.get<MainPageBloc>();
            instance.add(GetPlaces());
            return instance;
          },
        ),
      ],
      child: MaterialApp.router(
              routerConfig: GoRouter(routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: child,
                    bottomNavigationBar: NavBar(
                      onRouteChanged: (String route) {
                        context.go(route);
                      },
                      mainPageBloc: context.read<MainPageBloc>(),
                    ),
                    extendBody: true,
                  );
                },
                routes: [
                  GoRoute(path: "/", builder: (context, state) => MainPage()),
                  GoRoute(name: "contribute", path: "/contribute/:contribId", builder: (context, state) => MainPage(contributePlace: state.pathParameters['contribId'],)),
                  GoRoute(path: "/payment-details", builder: (context, state) => ParkingPaymentDetails()),
                  GoRoute(path: "/profile", builder: (context, state) => ProfilePage()),
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
