import 'package:flutter/material.dart';

class StopParkingButton extends StatelessWidget {
  final Function() onPressed;

  const StopParkingButton({super.key, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text('Прекини паркинг'),
    );
  }
}