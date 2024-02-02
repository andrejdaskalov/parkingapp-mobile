import 'package:equatable/equatable.dart';
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
}

enum ParkingType { free, zoned, private }
