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
      ),
      child: Text('Прекини паркинг'),
    );
  }
}