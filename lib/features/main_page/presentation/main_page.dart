import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/core/service/sms.dart';
import 'package:parkingapp/features/details/presentation/details_card.dart';
import 'package:parkingapp/features/parking_payment/presentation/payment_status_button.dart';
import '../../../core/domain/model/parking.dart';
import '../../registration_dialog/dialog.dart';
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
  ParkingPlace? place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ParkWise"),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        floatingActionButton: Padding(
          padding: MediaQuery.of(context).padding,
          child: PaymentStatusButton(),
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
                                      point: LatLng(e.location.latitude,
                                          e.location.longitude),
                                      width: 100,
                                      height: 100,
                                      child: IconButton.filled(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .white
                                                  .withOpacity(0.0)),
                                        ),
                                        icon: Icon(Icons.location_on,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            place = e;
                                          });
                                        },
                                      ),
                                    ))
                                .toList();
                          }
                          return FlutterMap(
                            options: MapOptions(
                                initialCenter: LatLng(41.99646, 21.43141),
                                //TODO: change to user location
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
            Builder(builder: (context) {
              if (place != null) {
                return Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: DetailsCard(
                    place: place!,
                    onDismiss: () {
                      setState(() {
                        place = null;
                      });
                    },
                    onPay: () {
                      this._showDialog();
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ));
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return RegistrationDialog(
            title: "Регистрација",
            message: "Внесете регистрација",
            sendSMS: (message, recipient) {
              getIt
                  .get<SMS>()
                  .sendSms(message + " " + place!.zone.toString(), recipient);
            },
          );
        });
  }
}
