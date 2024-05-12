import 'package:equatable/equatable.dart';

class UserInputNetwork extends Equatable {
  final String document_id;
  final double occupancy;
  final String parking_id;
  final DateTime datetime;
  final bool last_entry;

  UserInputNetwork(this.document_id, this.occupancy, this.parking_id, this.datetime, this.last_entry);

  @override
  List<Object?> get props => [document_id];

  factory UserInputNetwork.fromJson(Map<String, dynamic> json) {
    return UserInputNetwork(
      json['document_id'],
      json['occupancy'],
      json['parking_id'],
      json['datetime'],
      json['last_entry']
    );
  }


  @override
  String toString() {
    return 'UserInputNetwork{id: $document_id, occupancy: $occupancy, parking_id: $parking_id, date: $datetime, last_entry: $last_entry}';
  }
}
