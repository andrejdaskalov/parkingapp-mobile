import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/core/domain/model/availability.dart';
import 'package:parkingapp/features/details/presentation/details_card.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:parkingapp/features/parking_payment/presentation/payment_status_button.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/domain/model/parking.dart';
import '../../../core/repository/parking_repository.dart';
import '../../contribute/presentation/contribute_card.dart';
import '../../registration_dialog/dialog.dart';
import '../appbar/custom_app_bar.dart';
import 'bloc/main_page_bloc.dart';

class MainPage extends StatefulWidget {
  final String? contributePlace;

  MainPage({Key? key, this.contributePlace}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ParkingPlace? place;
  Availability? placeAvailability;
  bool detailsVisible = false;
  Position? userPosition;

  bool contributeVisible = false;
  String? contributePlace;

  initState() {
    super.initState();
    if (widget.contributePlace != null) {
      setState(() {
        contributeVisible = true;
        contributePlace = widget.contributePlace;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state.userPosition != null) {
          setState(() {
            this.userPosition = state.userPosition;
          });
        }
      },
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            context.push('/payment-details');
          },
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: PaymentStatusButton(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: BlocProvider(
          create: (context) {
            var instance = getIt.get<MainPageBloc>();
            instance.add(GetPlaces());
            return instance;
          },
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Flexible(
                      child: BlocBuilder<MainPageBloc, MainPageState>(
                        builder: (context, state) {
                          final Position? userPosition = this.userPosition;
                          final LatLng? userLocation = userPosition != null
                              ? LatLng(
                                  userPosition.latitude, userPosition.longitude)
                              : null;

                          var markers = <Marker>[];
                          var suggestions =
                              <String>[]; // List to store suggestions
                          if (state.status == Status.loaded) {
                            markers = state.places
                                .map(
                                  (e) => Marker(
                                    point: LatLng(e.location.latitude,
                                        e.location.longitude),
                                    width: 100,
                                    height: 100,
                                    child: IconButton.filled(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white.withOpacity(0.0)),
                                      ),
                                      icon: Icon(Icons.location_on,
                                          color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          place = e;
                                          placeAvailability =
                                              state.availability;
                                          detailsVisible = true;
                                        });
                                      },
                                    ),
                                  ),
                                )
                                .toList();

                            if (userLocation != null) {
                              markers.add(
                                Marker(
                                  point: userLocation,
                                  width: 100,
                                  height: 100,
                                  child: IconButton.filled(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white.withOpacity(0.0)),
                                    ),
                                    icon: Icon(Icons.location_on,
                                        color: Colors.blue),
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }

                            // Populate suggestions list
                            suggestions =
                                state.places.map((e) => e.name).toList();
                          }
                          return FlutterMap(
                            options: MapOptions(
                              initialCenter:
                                  userLocation ?? LatLng(41.99646, 21.43141),
                              initialZoom: 13,
                              interactionOptions: InteractionOptions(
                                enableMultiFingerGestureRace: true,
                                rotationThreshold: 20.0,
                              ),
                            ),
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
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (!detailsVisible) {
                  return Container();
                }
                var mainPageBloc = context.read<MainPageBloc>();
                return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 50),
                  child: Entry.offset(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    yOffset: -1000,
                    visible: detailsVisible,
                    child: DetailsCard(
                      place: place,
                      // availability: placeAvailability ?? Availability.empty(),
                      onDismiss: () {
                        setState(() {
                          detailsVisible = false;
                        });
                      },
                      onPay: () {
                        this._showDialog();
                      },
                      bloc: mainPageBloc,
                    ),
                  ),
                );
              }),

              // contribute card builder
              Builder(builder: (context) {
                if (!contributeVisible || contributePlace == null) {
                  return Container();
                }
                return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 50),
                  child: Entry.offset(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    yOffset: -1000,
                    visible: contributeVisible,
                    child: ContributeDetailsCard(
                      placeId: contributePlace!,
                      onDismiss: () {
                        setState(() {
                          contributeVisible = false;
                          contributePlace = null;
                        });
                        context.go('/');
                      },
                    ),
                  ),
                );
              }),
              CustomAppBar(onParkingSelected: (place) {
                setState(() {
                  this.place = place;
                  detailsVisible = true;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return RegistrationDialog(
            title: "Започни паркинг",
            message: "Внесете регистрација",
            sendSMS: (message, recipient) {
              context
                  .read<PaymentBloc>()
                  .add(StartParking(place!, message, recipient));
            },
          );
        });
  }
}
