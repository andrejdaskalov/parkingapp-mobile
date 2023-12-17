import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {

     var marker = <Marker>[];
     
     marker = [
       Marker(
         point: LatLng(42.0041,21.4095),
         width: 80,
         height: 80,
         child: Icon(Icons.location_on, color: Colors.red),
       ),Marker(
         point: LatLng(42.0035,21.4168),
         width: 80,
         height: 80,
         child: Icon(Icons.location_on, color: Colors.green),
       )
     ];

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
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(41.99646,21.43141),
                      initialZoom: 13,
                     ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a','b','c'],
                      ),
                      MarkerLayer(
                          markers: marker,
                      ),
                    ],

                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}