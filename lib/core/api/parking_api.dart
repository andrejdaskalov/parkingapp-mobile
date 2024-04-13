
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';

import '../domain/network_model/user_input_network.dart';


abstract interface class ParkingApi {
  Future<List<ParkingPlaceNetwork>> listParkings();
  Future<ParkingPlaceNetwork> getParking(String documentId);
  Future<UserInputNetwork> getUserInput(String documentId);
  Future<List<UserInputNetwork>> listUserInputs();


}