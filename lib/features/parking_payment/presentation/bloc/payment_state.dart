part of 'payment_bloc.dart';

final class PaymentState {
  final ParkingStatus status;
  final String? currentlyPayingParking;
  final String? error;
  final DateTime? startTime;
  final double? currentCost;
  final String? parkingZone;

  PaymentState(
      {required this.status,
      this.currentlyPayingParking,
      this.error,
      this.startTime,
      this.currentCost,
      this.parkingZone});
}

enum ParkingStatus {
  loading,
  loaded,
  error,
}
