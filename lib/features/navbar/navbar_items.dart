import 'package:flutter/material.dart';

class NavbarItem {
  final String title;
  final IconData icon;
  final String route;

  NavbarItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

final List<NavbarItem> navbarItems = [
  NavbarItem(title: 'Map', icon: Icons.map_outlined, route: '/'),
  NavbarItem(title: 'Profile', icon: Icons.badge_outlined, route: '/profile'),
  NavbarItem(title: 'My Location', icon: Icons.edit_location_outlined, route: '/'),
  // NavbarItem(title: 'Contribute', icon: Icons.edit_location_outlined, route: '/'),
];