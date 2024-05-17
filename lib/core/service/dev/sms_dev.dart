import 'package:injectable/injectable.dart';

import '../sms.dart';

@dev
@Injectable(as: SMSService)
class SMSDev implements SMSService {
  @override
  Future<void> sendSms(String message, String recipient, Function(SMSStatus) onResult) async {
    Future.delayed(Duration(seconds: 1));
    onResult(SMSStatus.sent);
  }
}