import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../api/parking_api.dart';
import '../domain/model/parking.dart';

@injectable
class ParkingRepository {
  final ParkingApi _parkingApi;
  ParkingRepository(this._parkingApi);

  Future<List<ParkingPlace>> listParkings() async {
    Future<List<ParkingPlace>> parkingPlaces = Future.value([]);

    await _parkingApi.listParkings().then((parkingPlaceNetworkList) {
      List<ParkingPlace> parkingPlaceList = parkingPlaceNetworkList.map((parkingPlaceNetwork) => ParkingPlace.fromNetwork(parkingPlaceNetwork)).toList();

      parkingPlaces = Future.value(parkingPlaceList);
    });

    return Future.value([]);
  }
}