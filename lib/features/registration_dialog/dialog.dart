import 'package:flutter/material.dart';


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
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(widget.title),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.message),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "XX0123YY",
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
}