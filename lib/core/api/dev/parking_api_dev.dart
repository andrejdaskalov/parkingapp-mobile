import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';
import 'package:parkingapp/core/domain/network_model/user_input_network.dart';
import 'package:uuid/uuid.dart';
import '../../domain/model/location.dart';
import '../../domain/model/parking.dart';
import '../parking_api.dart';

@dev
@Injectable(as: ParkingApi)
class ParkingApiDev implements ParkingApi {
  @override
  Future<List<ParkingPlaceNetwork>> listParkings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      // const ParkingPlace(
      //   Uuid(),
      //   "Parking 1",
      //   'Address 1',
      //   Location(42.004838, 21.401721),
      //   'Municipality 1',
      //   [Location(0, 0)],
      //   ParkingType.free,
      //   'Zone 1',
      //   'https://via.placeholder.com/150',
      // ),
      // const ParkingPlace(
      //   Uuid(),
      //   'Parking 2',
      //   'Address 2',
      //   Location(42.005184, 21.422498),
      //   'Municipality 2',
      //   [Location(0, 0)],
      //   ParkingType.zoned,
      //   'Zone 2',
      //   'https://via.placeholder.com/150',
      // ),
      // const ParkingPlace(
      //   Uuid(),
      //   'Parking 3',
      //   'Address 3',
      //   Location(41.980512, 21.470543),
      //   'Municipality 3',
      //   [Location(0, 0)],
      //   ParkingType.private,
      //   'Zone 3',
      //   'https://via.placeholder.com/150',
      // ),
    ];
  }

  @override
  Future<ParkingPlaceNetwork> getParking(String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ParkingPlaceNetwork(
      'Address 1',
      null,
      'Parking 1',
      'Parking 1',
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      'Zone 1',
      'f209a7b0-0b7d-11ec-9a03-0242ac130003',
    );
  }

  @override
  Future<UserInputNetwork> getUserInput(String documentId) {
    // TODO: implement getUserInput
    throw UnimplementedError();
  }

  @override
  Future<List<UserInputNetwork>> listUserInputs() {
    // TODO: implement listUserInputs
    throw UnimplementedError();
  }

}