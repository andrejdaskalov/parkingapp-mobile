import 'package:equatable/equatable.dart';
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';
import 'package:uuid/uuid.dart';
import 'location.dart';

class ParkingPlace extends Equatable {
  final Uuid id;
  final String name;
  final String address;
  final Location location;
  final String municipality;
  final List<Location> areaPoints;
  final ParkingType type;
  final String? zone;
  final String? imageUrl;
  // TODO: add pricing field

  const ParkingPlace(this.id, this.name, this.address, this.location,
      this.municipality, this.areaPoints, this.type, this.zone, this.imageUrl);

  @override
  List<Object?> get props => [id];

  @override
  toString() => "ParkingPlace($id, $name, $address, $location, $municipality, $areaPoints, $type, $zone, $imageUrl)";

  factory ParkingPlace.fromNetwork(ParkingPlaceNetwork network) {
    return ParkingPlace(
      Uuid(),
      network.parking_name ?? '',
      network.parking_address ?? '',
      Location(
        network.parking_coordinates?.latitude ?? 0,
        network.parking_coordinates?.longitude ?? 0,
      ),
      network.parking_zone ?? '',
      [],
      ParkingType.free,
      network.parking_zone,
      '',
    );
  }
}

enum ParkingType { free, zoned, private }
