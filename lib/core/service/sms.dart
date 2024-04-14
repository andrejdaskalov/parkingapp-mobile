import 'package:injectable/injectable.dart';

abstract interface class SMSService {
  Future<SMSStatus> sendSms(String message, String recipient) ;
}

enum SMSStatus { sent, error }