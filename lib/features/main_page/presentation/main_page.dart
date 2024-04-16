import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/features/details/presentation/details_card.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:parkingapp/features/parking_payment/presentation/payment_status_button.dart';
import '../../../core/domain/model/parking.dart';
import '../../registration_dialog/dialog.dart';
import '../appbar/custom_app_bar.dart';
import 'bloc/main_page_bloc.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ParkingPlace? place;
  bool detailsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: AppBar().preferredSize.height,
       // Empty list initially
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: GestureDetector(
          onTap: () {
            context.push('/payment-details');
          },
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: PaymentStatusButton(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,body: Stack(
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
                                            detailsVisible = true;
                                          });
                                        },
                                      ),
                                    ),
                          )
                              .toList();

                          // Populate suggestions list
                          suggestions = state.places.map((e) => e.name).toList();
                        }
                        return FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(41.99646, 21.43141),//TODO: change to user location
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
                      },),
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                if (!detailsVisible) {
                  return Container();
                }
                return Container(
                    margin:
                        EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Entry.offset(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      yOffset: -1000,
                      visible: detailsVisible,
                      child: DetailsCard(
                        place: place,
                        onDismiss: () {
                          setState(() {
                            detailsVisible = false;
                          });
                        },
                        onPay: () {
                          this._showDialog();
                    },
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return RegistrationDialog(
            title: "Регистрација",
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
