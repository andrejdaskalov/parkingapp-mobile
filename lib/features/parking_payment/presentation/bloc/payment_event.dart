part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class StartParking extends PaymentEvent {
  final ParkingPlace parkingPlace;
  final DateTime startTime = DateTime.now();
  final String message;
  final String recipient;

  StartParking(this.parkingPlace, this.message, this.recipient);
}

class StopParking extends PaymentEvent {
  final DateTime stopTime = DateTime.now();
  final String recipient;

  StopParking(this.recipient);
}

class GetParkingDetails extends PaymentEvent {
  GetParkingDetails();
}

class UpdateUserLocationP extends PaymentEvent {
  final Position position;

  UpdateUserLocationP(this.position);
}
