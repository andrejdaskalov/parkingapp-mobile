import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StopButton extends StatelessWidget {
  final Function() onPressed;

  const StopButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        // Call the method to show the confirmation dialog
        MainPagee.showConfirmationDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Set background color to red
        foregroundColor: Colors.white, // Set text color to white
      ),
      child: Text('Прекини Паркинг'),
    );
  }
}

class MainPagee extends StatelessWidget {
  MainPagee({Key? key}) : super(key: key);

  static Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
                await SharedPreferences.getInstance().then((prefs) {
                  debugPrint(prefs.getString("currentlyPayingParking"));

                  prefs.remove('currentlyPayingParking');
                  debugPrint(prefs.getString("currentlyPayingParking"));

                });
              },
              child: Text('Да'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParkWise"),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Flexible(
                  child: Container(), // Your map or other content here
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StopButton(
                    onPressed: () {
                      showConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
