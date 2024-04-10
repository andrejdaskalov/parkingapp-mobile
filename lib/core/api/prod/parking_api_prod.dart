import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/api/parking_api.dart';
import 'package:parkingapp/core/domain/model/parking.dart';

import '../../domain/network_model/parking_place_network.dart';

@prod
@Injectable(as: ParkingApi)
class ParkingApiProd implements ParkingApi {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  CollectionReference parkingPlaces = FirebaseFirestore.instance.collection('parkings');

  @override
  Future<List<ParkingPlaceNetwork>> listParkings() {
    return parkingPlaces.get().then((value) => value.docs.map((e) => ParkingPlaceNetwork.fromJson(e.data() as Map<String, dynamic>)).toList());
  }

}