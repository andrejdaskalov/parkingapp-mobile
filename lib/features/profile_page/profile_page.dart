import 'package:flutter/material.dart';
import 'package:parkingapp/features/common_ui/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ParkWise"),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 32),
            Text('Your Profile', style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your registration',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: _saveRegistration,
                  text: 'Save Registration',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    final registration = prefs.getString('registration');
    if (registration != null) {
      _controller.text = registration;
    }
  }

  void _saveRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('registration', _controller.text);
    Fluttertoast.showToast(
        msg: "Registration saved successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}