import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/domain/parking.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';

import '../../../core/dependency_injection/injectable_config.dart';
import 'bloc/main_page_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  var markers = <Marker>[
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
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Flexible(
                    child: FlutterMap(
                      options: MapOptions(
                          initialCenter: LatLng(41.99646,21.43141),
                          initialZoom: 13,
                          interactionOptions: InteractionOptions(
                            enableMultiFingerGestureRace: true,
                            rotationThreshold: 20.0,
                          )
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a','b','c'],
                        ),
                        MarkerLayer(
                          markers: markers,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocProvider(
              create: (context) {
                var instance = getIt.get<MainPageBloc>();
                instance.add(GetPlaces());
                return instance;
              },
              child: BlocBuilder<MainPageBloc, MainPageState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == Status.error) {
                    return Center(child: Text(state.error));
                  } else {
                    return ListView.builder(
                      itemCount: state.places.length,
                      itemBuilder: (context, index) {
                        final place = state.places[index];
                        return ListTile(
                          title: Text(place.name),
                          subtitle: Text(place.address),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
