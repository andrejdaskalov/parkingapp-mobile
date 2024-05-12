import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationDialog extends StatefulWidget {
  final String title;
  final String message;
  final void Function(String message, String recipient) sendSMS;

  RegistrationDialog({
    required this.title,
    required this.message,
    required this.sendSMS,
  });

  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(widget.title),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.message),
              ),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "XX0123YY",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("Откажи")),
          TextButton(onPressed: () {
            widget.sendSMS(_controller.text, "144144");
            Navigator.of(context).pop();
          }, child: Text("Потврди")),
        ],
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
}