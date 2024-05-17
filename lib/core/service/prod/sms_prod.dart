import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:injectable/injectable.dart';

import '../sms.dart';

@prod
@Injectable(as: SMSService)
class SMSProd implements SMSService {

  Future<void> sendSms(String message, String recipient, Function(SMSStatus) onResult) async {
    String _result = await sendSMS(recipients: [recipient], message: message, sendDirect: true);
    if (_result == "OK") {
      onResult(SMSStatus.sent);
    } else {
      onResult(SMSStatus.error);
    }
  }

}
