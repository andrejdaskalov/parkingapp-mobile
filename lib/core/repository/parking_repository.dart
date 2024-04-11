import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../api/parking_api.dart';
import '../domain/model/parking.dart';

@injectable
class ParkingRepository {
  final ParkingApi _parkingApi;
  ParkingRepository(this._parkingApi);

  Future<List<ParkingPlace>> listParkings() async {
    return _parkingApi.listParkings().then((parkingPlaceNetworkList) {
      return parkingPlaceNetworkList.map((parkingPlaceNetwork) => ParkingPlace.fromNetwork(parkingPlaceNetwork)).toList();
    });
  }
}