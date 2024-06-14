import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/model/availability.dart';

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

  Future<ParkingPlace> getParkingPlace(String documentId) async {
    return _parkingApi.getParking(documentId).then((parkingPlaceNetwork) {
      return ParkingPlace.fromNetwork(parkingPlaceNetwork);
    });
  }

  Future<Availability> getUserInputsAverage(String documentId) async {
    bool hasInputs = await _parkingApi.checkForInputsToday(documentId);
    double averageOccupancy = hasInputs ?
       await _parkingApi.getUserInputsAverageToday(documentId)
    :
       await _parkingApi.getUserInputsAverage(documentId);

    return Availability(parkingId: documentId, averageOccupancy: averageOccupancy, hasEntriesToday: hasInputs);
  }

  Future<void> addParkingInput(String parkingId, double input) async {
    return await _parkingApi.addParkingInput(parkingId, input);
  }
}