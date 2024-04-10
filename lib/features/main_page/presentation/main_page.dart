import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/domain/parking.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/features/main_page/appbar/custom_app_bar.dart';
import 'bloc/main_page_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: AppBar().preferredSize.height,
       // Empty list initially
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Flexible(
                  child: BlocProvider(
                    create: (context) {
                      var instance = getIt.get<MainPageBloc>();
                      instance.add(GetPlaces());
                      return instance;
                    },
                    child: BlocBuilder<MainPageBloc, MainPageState>(
                      builder: (context, state) {
                        var markers = <Marker>[];
                        var suggestions = <String>[]; // List to store suggestions
                        if (state.status == Status.loaded) {
                          markers = state.places
                              .map(
                                (e) => Marker(
                              point: LatLng(e.location.latitude, e.location.longitude),
                              width: 80,
                              height: 80,
                              child: Icon(Icons.location_on, color: Colors.red),
                            ),
                          )
                              .toList();

                          // Populate suggestions list
                          suggestions = state.places.map((e) => e.name).toList();
                        }
                        return FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(41.99646, 21.43141),
                            initialZoom: 13,
                            interactionOptions: InteractionOptions(
                              enableMultiFingerGestureRace: true,
                              rotationThreshold: 20.0,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: markers,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
