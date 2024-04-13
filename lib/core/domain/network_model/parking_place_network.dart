import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ParkingPlaceNetwork extends Equatable {
  final String document_id;
  final String? parking_address;

  final GeoPoint? parking_coordinates;

  final String? parking_id;

  final String? parking_name;

  final int? parking_price_per_extra_hour;

  final int? parking_price_per_hour;

  final int? parking_spots_count;

  final int? parking_spots_for_bicycles_count;

  final int? parking_spots_for_busses_count;

  final int? parking_spots_for_disabled_count;

  final int? parking_spots_for_electric_vehicles_count;

  final int? parking_spots_for_motorcycles_count;

  final int? parking_spots_for_taxi_count;

  final int? parking_spots_for_trucks_count;

  final String? parking_zone;

  const ParkingPlaceNetwork(
      this.parking_address,
      this.parking_coordinates,
      this.parking_id,
      this.parking_name,
      this.parking_price_per_extra_hour,
      this.parking_price_per_hour,
      this.parking_spots_count,
      this.parking_spots_for_bicycles_count,
      this.parking_spots_for_busses_count,
      this.parking_spots_for_disabled_count,
      this.parking_spots_for_electric_vehicles_count,
      this.parking_spots_for_motorcycles_count,
      this.parking_spots_for_taxi_count,
      this.parking_spots_for_trucks_count,
      this.parking_zone, this.document_id);

  @override
  List<Object?> get props => [document_id];

  @override
  toString() =>
      "ParkingPlaceNetwork($document_id, $parking_address, $parking_coordinates, $parking_id, $parking_name, $parking_price_per_extra_hour, $parking_price_per_hour, $parking_spots_count, $parking_spots_for_bicycles_count, $parking_spots_for_busses_count, $parking_spots_for_disabled_count, $parking_spots_for_electric_vehicles_count, $parking_spots_for_motorcycles_count, $parking_spots_for_taxi_count, $parking_spots_for_trucks_count, $parking_zone)";

  factory ParkingPlaceNetwork.fromJson(Map<String, dynamic> json) {
    return ParkingPlaceNetwork(
      json['parking_address'],
      json['parking_coordinates'],
      json['parking_id'],
      json['parking_name'],
      json['parking_price_per_extra_hour'],
      json['parking_price_per_hour'],
      json['parking_spots_count'],
      json['parking_spots_for_bicycles_count'],
      json['parking_spots_for_busses_count'],
      json['parking_spots_for_disabled_count'],
      json['parking_spots_for_electric_vehicles_count'],
      json['parking_spots_for_motorcycles_count'],
      json['parking_spots_for_taxi_count'],
      json['parking_spots_for_trucks_count'],
      json['parking_zone'],
      json['document_id'],
    );
  }
}
