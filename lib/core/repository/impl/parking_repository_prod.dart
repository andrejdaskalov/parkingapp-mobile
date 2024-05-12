import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../api/parking_api.dart';
import '../../domain/model/parking.dart';
import '../../domain/network_model/parking_place_network.dart';
import '../parking_repository.dart';

@Injectable(as: ParkingRepository)
@prod
class ParkingRepositoryProd implements ParkingRepository {
  final ParkingApi _parkingApi;

  ParkingRepositoryProd(this._parkingApi);

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

}
