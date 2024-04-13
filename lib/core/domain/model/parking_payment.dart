import 'package:equatable/equatable.dart';

class ParkingPaymentDetails extends Equatable {
  final String parkingPlaceId;
  final DateTime startTime;


  ParkingPaymentDetails(
      {required this.parkingPlaceId,
      required this.startTime,
      }) ;

  @override
  List<Object?> get props => [parkingPlaceId, startTime];
}
