import 'package:injectable/injectable.dart';

abstract interface class SMSService {
  Future<void> sendSms(String message, String recipient, Function(SMSStatus) onResult);
}

enum SMSStatus { sent, error }