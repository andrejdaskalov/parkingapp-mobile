import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../api/parking_api.dart';
import '../../domain/model/parking.dart';
import '../../domain/network_model/parking_place_network.dart';
import '../i_parking_repository.dart';

@injectable
class ParkingRepository implements IParkingRepository {
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

  //TODO vidi ova dali vaka treba
  @override
  Future<ParkingPlace> getParkingPlace(String documentId) async {
    final parkingPlace = await _parkingApi.getParking(documentId);
    return ParkingPlace.fromNetwork(parkingPlace);
  }
}
