import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/domain/parking.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/features/parking_payment/presentation/stop_parking_button.dart';
import '../../parking_payment/presentation/stop_parking_dialog.dart';
import '../../parking_payment/service/payment_service.dart';
import 'bloc/main_page_bloc.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PaymentService paymentService = getIt<PaymentService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ParkWise"),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: FutureBuilder(
            future: paymentService.getCurrentlyPayingParking(),
          initialData: "",
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const SizedBox.shrink();
            }
            return Padding(
            padding: MediaQuery.of(context).padding + const EdgeInsets.only(bottom: 80.0),
            child: StopParkingButton(onPressed: () async {
              showDialog(context: context, builder: (context) => StopParkingDialog(onStop: () async {
                paymentService.clearCurrentlyPayingParking();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Паркингот е успешно прекинат!'),
                  duration: const Duration(seconds: 2),
                ));
                await paymentService.clearCurrentlyPayingParking();
              },));
            }),
          );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          if (state.status == Status.loaded) {
                            markers = state.places
                                .map((e) => Marker(
                              point: LatLng(e.location.latitude, e.location.longitude),
                              width: 80,
                              height: 80,
                              child: Icon(Icons.location_on, color: Colors.red),
                            ))
                                .toList();
                          }
                          return FlutterMap(
                            options: MapOptions(
                                initialCenter: LatLng(41.99646, 21.43141),
                                initialZoom: 13,
                                interactionOptions: InteractionOptions(
                                  enableMultiFingerGestureRace: true,
                                  rotationThreshold: 20.0,
                                )),
                            children: [
                              TileLayer(
                                urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
        ));
  }
}
