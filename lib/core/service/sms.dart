import 'package:flutter/cupertino.dart';
import 'package:telephony_sms/telephony_sms.dart';
import 'package:injectable/injectable.dart';

@injectable
class SMS {
  final _telephonySMS = TelephonySMS();

  void sendSms(String message, String recipient) async {
    await _telephonySMS.requestPermission();

    await _telephonySMS.sendSMS(phone: recipient, message: message).then((value) {
      print("SMS sent");
    }).catchError((error) {
      print("Error sending SMS: $error");
    });
  }
}
