import 'package:equatable/equatable.dart';

class Availability extends Equatable {
  final String parkingId;
  final bool hasEntriesToday;
  final double averageOccupancy;

  Availability({
    required this.parkingId,
    required this.hasEntriesToday,
    required this.averageOccupancy,
  });

  @override
  List<Object?> get props => [parkingId, hasEntriesToday, averageOccupancy];

  static Availability empty() {
    return Availability(
      parkingId: "",
      hasEntriesToday: false,
      averageOccupancy: 0.0,
    );
  }

}