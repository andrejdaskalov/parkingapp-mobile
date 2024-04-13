part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class StartParking extends PaymentEvent {
  final ParkingPlace parkingPlace;
  final DateTime startTime = DateTime.now();

  StartParking(this.parkingPlace);
}

class StopParking extends PaymentEvent {
  final DateTime stopTime = DateTime.now();

  StopParking();
}

class GetParkingDetails extends PaymentEvent {
  GetParkingDetails();
}