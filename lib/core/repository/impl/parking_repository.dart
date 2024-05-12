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
    return _parkingApi.listParkings().then((parkingPlaceNetworkList) {
      return parkingPlaceNetworkList.map((parkingPlaceNetwork) => ParkingPlace.fromNetwork(parkingPlaceNetwork)).toList();
    });
  }

  Future<ParkingPlace> getParkingPlace(String documentId) async {
    return _parkingApi.getParking(documentId).then((parkingPlaceNetwork) {
      return ParkingPlace.fromNetwork(parkingPlaceNetwork);
    });
  }

  //TODO vidi ova dali vaka treba
  @override
  Future<ParkingPlace> getParkingPlace(String documentId) async {
    final parkingPlace = await _parkingApi.getParking(documentId);
    return ParkingPlace.fromNetwork(parkingPlace);
  }
}
