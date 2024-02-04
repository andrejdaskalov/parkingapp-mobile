import 'package:flutter/material.dart';
import 'package:parkingapp/features/main_page/presentation/main_page.dart';
import 'core/dependency_injection/injectable_config.dart';
import 'package:flutter/services.dart';

void main() {
  String environment = appFlavor.toString();
  configureDependencies(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(1, 62, 120, 178)),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
