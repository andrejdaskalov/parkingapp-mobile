import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';
import 'package:parkingapp/features/common_ui/buttons.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/domain/model/parking.dart';

class ContributeDetailsCard extends StatefulWidget {
  final ParkingRepository parkingRepository;

  ContributeDetailsCard({required this.parkingRepository});

  @override
  _ContributeDetailsCardState createState() => _ContributeDetailsCardState(parkingRepository);
}

class _ContributeDetailsCardState extends State<ContributeDetailsCard> {
  final ParkingRepository _parkingRepository;
  ParkingPlace? place;
  bool contributeVisible = true;
  late StreamSubscription<PaymentState> _paymentBlocSubscription;

  _ContributeDetailsCardState(this._parkingRepository);

  @override
  void initState() {
    super.initState();
    _loadPlace();
    _paymentBlocSubscription = context.read<PaymentBloc>().stream.listen((state) {
      if (!this.contributeVisible) {
        _loadPlace();
      }
    });
  }

  @override
  void dispose() {
    _paymentBlocSubscription.cancel();
    super.dispose();
  }

  void _loadPlace() async {
    final prefs = await SharedPreferences.getInstance();
    final placeId = prefs.getString('shouldContributeForParking');
    if (placeId != null) {
      final fetchedPlace = await _parkingRepository.getParkingPlace(placeId);
      setState(() {
        this.place = fetchedPlace;
        this.contributeVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!contributeVisible || place == null) {
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
        child: Dismissible(
          key: Key(place!.id),
          direction: DismissDirection.up,
          onDismissed: (direction) {
            _clearContributeForParking();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 300,
            child: Card(
              color: Theme.of(context).colorScheme.background,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TitleHeading(text: place!.name),
                                BoldHeading(text: place!.address),
                                SubtitleHeading(text: "Колку е зафатен паркингот?"),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZoneLabel(text: "Зона"),
                            ZoneHeading(text: place!.zone.toString()),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.green),
                              child: Text(""),
                              onPressed: () {
                                _clearContributeForParking();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                              child: Text(""),
                              onPressed: () {
                                _clearContributeForParking();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.orange),
                              child: Text(""),
                              onPressed: () {
                                _clearContributeForParking();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text(""),
                              onPressed: () {
                                _clearContributeForParking();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Речиси слободен"),
                            Text("Речиси преполн"),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearContributeForParking() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('shouldContributeForParking');

    setState(() {
      this.contributeVisible = false;
    });
  }
}