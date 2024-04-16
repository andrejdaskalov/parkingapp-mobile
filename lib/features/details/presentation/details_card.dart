import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/features/common_ui/buttons.dart';
import 'package:parkingapp/features/common_ui/headings.dart';

import '../../../core/domain/model/parking.dart';


class DetailsCard extends StatelessWidget {
  final ParkingPlace? place;
  final void Function() onDismiss;
  final void Function() onPay;

  const DetailsCard({Key? key, required this.place, required this.onDismiss, required this.onPay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (place == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Dismissible(
          key: Key(place!.id),
          direction: DismissDirection.up,
          onDismissed: (direction) {
            onDismiss();
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TitleHeading(text: place!.name),
                            BoldHeading(text: place!.address),
                            SubtitleHeading(text: place!.type.name + " паркинг"),
                          ],
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
                            PrimaryButtonWithIcon(icon: Icons.local_parking, text: "Започни паркинг", onPressed: onPay)
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
              )
            ),
          ),
        );
      }
    );
  }
}
