import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
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
      body: const Text("hello world"),
    );
  }
}