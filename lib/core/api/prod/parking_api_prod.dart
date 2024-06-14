import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/api/parking_api.dart';
import 'package:parkingapp/core/domain/model/parking.dart';

import '../../domain/network_model/parking_place_network.dart';

@prod
@Injectable(as: ParkingApi)
class ParkingApiProd implements ParkingApi {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference parkingPlaces = FirebaseFirestore.instance.collection('parkings');
  CollectionReference userInputs = FirebaseFirestore.instance.collection('user_input');

  @override
  Future<List<ParkingPlaceNetwork>> listParkings() {
    return parkingPlaces.get().then((value) => value.docs.map((e) {
      var data = e.data() as Map<String, dynamic>;
      data['document_id'] = e.id;

      return ParkingPlaceNetwork.fromJson(data);
    }).toList());
  }

  @override
  Future<ParkingPlaceNetwork> getParking(String documentId) {
    return parkingPlaces.doc(documentId).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      data['document_id'] = value.id;

      return ParkingPlaceNetwork.fromJson(data);
    });
  }

  @override
  Future<double> getUserInputsAverage(String documentId) async {
    return await userInputs
        .where('parking_id', isEqualTo: documentId)
        .aggregate(average('occupancy'))
        .get().then((value) {
          return value.getAverage('occupancy') ?? 0.0;
    });
  }

  @override
  Future<double> getUserInputsAverageToday(String documentId) async {
    return await userInputs
        .where('parking_id', isEqualTo: documentId)
        .where('time', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
        .aggregate(average('occupancy'))
        .get().then((value) {
      return value.getAverage('occupancy') ?? 0.0;
    });
  }

  Future<bool> checkForInputsToday(String documentId) async {
    return await userInputs
        .where('parking_id', isEqualTo: documentId)
        .where('time', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
        .get().then((value) {
      return value.docs.isNotEmpty;
    });
  }

  @override
  Future<void> addParkingInput(String parkingId, double input) async {
    await userInputs.where('last_entry', isEqualTo: true).get().then((value) {
      value.docs.forEach((element) {
        userInputs.doc(element.id).update({'last_entry': false});
      });
    });
    await userInputs.add({
      'parking_id': parkingId,
      'occupancy': input,
      'time': DateTime.now(),
      'last_entry': true
    });
  }

}