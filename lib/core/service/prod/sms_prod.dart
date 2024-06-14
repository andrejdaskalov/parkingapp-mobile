import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../sms.dart';

@prod
@Injectable(as: SMSService)
class SMSProd implements SMSService {

  Future<void> sendSms(String message, String recipient, Function(SMSStatus) onResult) async {
    await Permission.sms.request().then((value) {
      if (value.isDenied) {
        onResult(SMSStatus.error);
      }
    });
    String _result = await sendSMS(recipients: [recipient], message: message, sendDirect: true);
    if (_result == "OK") {
      onResult(SMSStatus.sent);
    } else {
      onResult(SMSStatus.error);
    }
  }

}
