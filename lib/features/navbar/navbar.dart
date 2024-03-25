import 'package:flutter/material.dart';
import 'package:parkingapp/features/navbar/navbar_items.dart';

class NavBar extends StatefulWidget {
  NavBar({
    super.key,
    required this.onRouteChanged,
  });
  final Function(String) onRouteChanged;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(6, 9),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,

      child: BottomNavigationBar(
        items: navbarItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.title,
          );
        }).toList(),
        onTap: (index) {
          // Handle navigation
          widget.onRouteChanged.call(navbarItems[index].route);
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}