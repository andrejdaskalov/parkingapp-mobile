import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/model/parking_payment.dart';
import 'package:parkingapp/core/service/shared_prefs_service.dart';

@injectable
class PaymentService {
  final SharedPrefsService _sharedPrefsService;
  PaymentService(this._sharedPrefsService);

  static const String _parkingIdKey = 'currentlyPayingParking';
  static const String _startTimeKey = 'startTime';

  Future<ParkingPaymentDetails?> getCurrentlyPayingParking() async {
     String? parkingId = await _sharedPrefsService.getPreference(_parkingIdKey);
      if (parkingId == null) {
        return null;
      }
      String? startTimeString = await _sharedPrefsService.getPreference(_startTimeKey);
      DateTime? startTime = startTimeString != null ? DateTime.parse(startTimeString) : DateTime.now();
      return ParkingPaymentDetails(parkingPlaceId: parkingId, startTime: startTime);
  }
  Future<void> setCurrentlyPayingParking(String parkingId, DateTime startDate) async {
    await _sharedPrefsService.setPreference(_parkingIdKey, parkingId);
    await _sharedPrefsService.setPreference(_startTimeKey, startDate.toIso8601String());

    await _sharedPrefsService.setPreference("shouldContributeForParking", parkingId);
  }

  Future<void> clearCurrentlyPayingParking() async {
    await _sharedPrefsService.clearPreference(_parkingIdKey);
    await _sharedPrefsService.clearPreference(_startTimeKey);
  }


}