import 'package:injectable/injectable.dart';

import '../api/parking_api.dart';
import '../domain/parking.dart';

@injectable
class ParkingRepository {
  final ParkingApi _parkingApi;
  ParkingRepository(this._parkingApi);

  Future<List<ParkingPlace>> listParkings() {
    return _parkingApi.listParkings();
  }

}