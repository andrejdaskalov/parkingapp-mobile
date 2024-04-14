import 'package:injectable/injectable.dart';

import '../sms.dart';

@dev
@Injectable(as: SMSService)
class SMSDev implements SMSService {
  @override
  Future<SMSStatus> sendSms(String message, String recipient) async {
    Future.delayed(Duration(seconds: 1));
    return SMSStatus.sent;
  }
}