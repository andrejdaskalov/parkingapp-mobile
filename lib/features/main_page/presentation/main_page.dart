import 'package:flutter/material.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';

import '../../../core/dependency_injection/injectable_config.dart';


class MainPage extends StatelessWidget {
  MainPage({super.key});

  final ParkingRepository parkingRepository = getIt<ParkingRepository>();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      appBar: AppBar(
        title: const Text("ParkMe"),
        backgroundColor: Colors.transparent,
      ),
      body: Text(parkingRepository.listParkings().toString()),

    );
  }
}