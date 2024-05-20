part of 'payment_bloc.dart';

final class PaymentState {
  final ParkingStatus status;
  final String? currentlyPayingParking;
  final String? error;
  final DateTime? startTime;
  final double? currentCost;
  final String? parkingZone;
  final Position? userPosition;

  PaymentState(
      {required this.status,
      this.currentlyPayingParking,
      this.error,
      this.startTime,
      this.currentCost,
      this.parkingZone,
      this.userPosition});
}

enum ParkingStatus {
  loading,
  loaded,
  stopped,
  error,
}
