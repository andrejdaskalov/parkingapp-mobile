import 'package:flutter/cupertino.dart';
import 'package:telephony_sms/telephony_sms.dart';
import 'package:injectable/injectable.dart';

import '../sms.dart';

@prod
@Injectable(as: SMSService)
class SMSProd implements SMSService {
  final _telephonySMS = TelephonySMS();

  Future<SMSStatus> sendSms(String message, String recipient) async {
    await _telephonySMS.requestPermission();

    await _telephonySMS.sendSMS(phone: recipient, message: message).then((value) {
      return SMSStatus.sent;
    }).catchError((error) {
      return SMSStatus.error;
    });
    return SMSStatus.error;

  }

}
