import 'dart:ffi';
import 'package:equatable/equatable.dart';
import 'package:parkingapp/core/domain/model/parking.dart';

import '../network_model/user_input_network.dart';

class UserInput extends Equatable {
  final String id;
  final double occupancy;
  final ParkingPlace parkingPlace;
  final int date;
  final bool  lastEntry;

  UserInput(this.id, this.occupancy, this.parkingPlace, this.date, this.lastEntry);

  @override
  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'UserInput{id: $id, occupancy: $occupancy, parking: $parkingPlace, date: $date,last entry $lastEntry}';
  }

  factory UserInput.fromNetwork(UserInputNetwork network, ParkingPlace parkingPlace) {
    return UserInput(
        network.document_id, network.occupancy, parkingPlace, network.datetime,network.last_entry
    );
  }
}
