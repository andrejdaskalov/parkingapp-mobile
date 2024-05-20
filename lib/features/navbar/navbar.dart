import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/navbar/navbar_items.dart';

import 'package:geolocator/geolocator.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main_page/presentation/bloc/main_page_bloc.dart';

class NavBar extends StatefulWidget {
  final Function(String) onRouteChanged;
  final MainPageBloc mainPageBloc;

  NavBar({
    required this.onRouteChanged,
    required this.mainPageBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  MainPageBloc get mainPageBloc => widget.mainPageBloc;

  Future<Position> _getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      // Handle the case when the user denies the permission
      print('Location permission is denied');
      return Future.error('Location permission is denied');
    }
  }

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
        backgroundColor: Theme.of(context).colorScheme.background,
        items: navbarItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.title,
          );
        }).toList(),
        onTap: (index) {
          if (navbarItems[index].title == 'My Location') {
            _getCurrentLocation().then((position) {
              // Dispatch the UpdateUserLocation event
              context.read<PaymentBloc>().add(UpdateUserLocationP(position));
            });
          }

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