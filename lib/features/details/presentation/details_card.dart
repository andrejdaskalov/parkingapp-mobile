import 'dart:ffi';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/domain/model/availability.dart';
import 'package:parkingapp/features/common_ui/buttons.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:parkingapp/features/details/presentation/availability_slider.dart';
import 'package:parkingapp/features/main_page/presentation/bloc/main_page_bloc.dart';

import '../../../core/domain/model/parking.dart';

class DetailsCard extends StatelessWidget {
  final ParkingPlace? place;
  final void Function() onDismiss;
  final void Function() onPay;
  // final Availability availability;
  final MainPageBloc bloc;

  const DetailsCard(
      {Key? key,
      required this.place,
      required this.onDismiss,
      required this.onPay,
      // required this.availability,
      required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
            if (place == null) {
              return Center(child: CircularProgressIndicator());
            }
            bloc.add(SelectPlace(place!));
            Availability availability = state.availability ?? Availability.empty();
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              onDismissed: (direction) {
                onDismiss();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TitleHeading(text: place!.name),
                                        BoldHeading(text: place!.address),
                                        Container(height: 10,),
                                        SubtitleHeading(text: place!.type == ParkingType.zoned ? "Зонско паркирање" : "Слободно паркирање"),
                                        AvailabilitySlider(availability: availability ),
                                        Container(height: 10,),
                                        SubtitleHeading(text: "Цена: ${place!.pricePerHour} ден/час"),
                                        Container(height: 25,),

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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PrimaryButtonWithIcon(
                                        icon: Icons.local_parking,
                                        text: "Започни паркинг",
                                        onPressed: onPay)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
            );
        },
      ),
    );
  }
}
