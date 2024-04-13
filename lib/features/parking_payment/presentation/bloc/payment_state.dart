part of 'payment_bloc.dart';

final class PaymentState {
  final ParkingStatus status;
  final String? currentlyPayingParking;
  final String? error;
  final String? startTime;
  final double? currentCost;

  PaymentState(
      {required this.status,
      this.currentlyPayingParking,
      this.error,
      this.startTime,
      this.currentCost});
}

enum ParkingStatus {
  loading,
  loaded,
  error,
}
