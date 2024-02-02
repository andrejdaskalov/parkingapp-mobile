import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/parking.dart';
import 'package:uuid/uuid.dart';
import '../../domain/location.dart';
import '../parking_api.dart';

@dev
@Injectable(as: ParkingApi)
class ParkingApiDev implements ParkingApi {
  @override
  List<ParkingPlace> listParkings() {
    return [
      const ParkingPlace(
        Uuid(),
        "Parking 1",
        'Address 1',
        Location(0, 0),
        'Municipality 1',
        [Location(0, 0)],
        ParkingType.free,
        'Zone 1',
        'https://via.placeholder.com/150',
      ),
      const ParkingPlace(
        Uuid(),
        'Parking 2',
        'Address 2',
        Location(0, 0),
        'Municipality 2',
        [Location(0, 0)],
        ParkingType.zoned,
        'Zone 2',
        'https://via.placeholder.com/150',
      ),
      const ParkingPlace(
        Uuid(),
        'Parking 3',
        'Address 3',
        Location(0, 0),
        'Municipality 3',
        [Location(0, 0)],
        ParkingType.private,
        'Zone 3',
        'https://via.placeholder.com/150',
      ),
    ];
  }

}