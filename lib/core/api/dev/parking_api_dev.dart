import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';
import '../parking_api.dart';

@dev
@Injectable(as: ParkingApi)
class ParkingApiDev implements ParkingApi {
  @override
  Future<List<ParkingPlaceNetwork>> listParkings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const ParkingPlaceNetwork(
        'Address 1',
        GeoPoint(42.004838, 21.401721),
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
        'D42',
        'f209a7b0-0b7d-11ec-9a03-0242ac130003',
      ),
      const ParkingPlaceNetwork(
        'Address 2',
        GeoPoint(42.005184, 21.422498),
        'Parking 2',
        'Parking 2',
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
        'C2',
        'f209a7b0-0b7d-11ec-9a03-0242ac130003',
      ),
      const ParkingPlaceNetwork(
        'Address 3',
        GeoPoint(41.980512, 21.470543),
        'Parking 3',
        'Parking 3',
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
        'A3',
        'f209a7b0-0b7d-11ec-9a03-0242ac130003',
      ),
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
      'Z1',
      'f209a7b0-0b7d-11ec-9a03-0242ac130003',
    );
  }

  @override
  Future<double> getUserInputsAverage(String documentId) {
    return Future.value(0.69);
  }

  @override
  Future<double> getUserInputsAverageToday(String documentId) {
    return Future.value(0.42);
  }

  @override
  Future<bool> checkForInputsToday(String documentId) {
    return Random().nextBool() ? Future.value(true) : Future.value(false);
  }

  @override
  Future<void> addParkingInput(String parkingId, double input) {
    return Future.delayed(const Duration(milliseconds: 500));
  }

}