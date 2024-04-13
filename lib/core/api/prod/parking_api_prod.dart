import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/api/parking_api.dart';
import 'package:parkingapp/core/domain/model/parking.dart';
import 'package:parkingapp/core/domain/network_model/user_input_network.dart';

import '../../domain/network_model/parking_place_network.dart';

@prod
@Injectable(as: ParkingApi)
class ParkingApiProd implements ParkingApi {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference parkingPlaces =
      FirebaseFirestore.instance.collection('parkings');
  CollectionReference userInputs =
      FirebaseFirestore.instance.collection('user_input');

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

  //---------------------------------------------
  @override
  Future<UserInputNetwork> getUserInput(String documentId) {
    return userInputs.doc(documentId).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      data['document_id'] = value.id;

      return UserInputNetwork.fromJson(data);
    });
  }

  @override
  Future<List<UserInputNetwork>> listUserInputs() {
    return userInputs.get().then((value) => value.docs.map((e) {
          var data = e.data() as Map<String, dynamic>;
          data['document_id'] = e.id;

          return UserInputNetwork.fromJson(data);
        }).toList());
  }
}
