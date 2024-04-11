import 'package:equatable/equatable.dart';
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';
import 'package:uuid/uuid.dart';
import 'location.dart';

class ParkingPlace extends Equatable {
  final String id;
  final String name;
  final String address;
  final Location location;
  final String municipality;
  final List<Location> areaPoints;
  final ParkingType type;
  final String? zone;
  final String? imageUrl;
  final int? pricePerHour;
  final int? occupiedPercentage;
  // TODO: add pricing field

  const ParkingPlace(this.id, this.name, this.address, this.location,
      this.municipality, this.areaPoints, this.type, this.zone, this.imageUrl,
      this.pricePerHour, this.occupiedPercentage);

  @override
  List<Object?> get props => [id];

  @override
  toString() => "ParkingPlace($id, $name, $address, $location, $municipality, $areaPoints, $type, $zone, $imageUrl, $pricePerHour, $occupiedPercentage)";

  factory ParkingPlace.fromNetwork(ParkingPlaceNetwork network) {
    return ParkingPlace(
      network.document_id,
      network.parking_name ?? '',
      network.parking_address ?? '',
      Location(
        network.parking_coordinates?.latitude ?? 0,
        network.parking_coordinates?.longitude ?? 0,
      ),
      network.parking_zone ?? '',
      [],
      (network.parking_price_per_hour ?? 0) > 0 ? ParkingType.zoned : ParkingType.free,
      network.parking_zone,
      '',
      network.parking_price_per_hour ?? 0,
      66,
    );
  }
}

enum ParkingType { free, zoned, private }
