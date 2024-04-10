import 'package:flutter/material.dart';

import '../../../core/domain/parking.dart';

class DetailsCard extends StatelessWidget {
  final ParkingPlace place;
  final void Function() onDismiss;
  final void Function() onPay;

  const DetailsCard({Key? key, required this.place, required this.onDismiss, required this.onPay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text(place.name, style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),),
                      Text(place.address, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),),
                      Text(place.type.name + " паркинг", style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onBackground),),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Зона", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff144160)),),
                          Text(place.zone ?? "", style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold, color: Color(0xff144160)),)
                        ],
                      ),
                      IconButton(onPressed: () {
                        onDismiss();
                      }, icon: Icon(Icons.close),)
                    ],
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () {
                    onPay();
                  }, child: Text("Започни паркинг"),
                  )
                ],
              )

            ],
          ),
        )
      ),
    );
  }
}
