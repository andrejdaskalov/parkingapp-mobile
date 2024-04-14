import 'package:flutter/material.dart';
import 'package:parkingapp/features/parking_payment/service/payment_service.dart';

import '../../../core/dependency_injection/injectable_config.dart';

class StopParkingDialog extends StatelessWidget {

  final Function onStop;


  StopParkingDialog({required this.onStop});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Дали сте сигурни?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Не'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(); // Close the dialog
            // Perform action when 'Yes' is clicked
            // For example, you can navigate to a new screen
            // Remove the value of "currentlyPayingParking" from shared preferences
            onStop();
          },
          child: Text('Да'),
        ),
      ],
    );
  }
}