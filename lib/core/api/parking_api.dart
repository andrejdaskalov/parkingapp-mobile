
import 'package:parkingapp/core/domain/network_model/parking_place_network.dart';


abstract interface class ParkingApi {
  Future<List<ParkingPlaceNetwork>> listParkings();
  Future<ParkingPlaceNetwork> getParking(String documentId);
  Future<double> getUserInputsAverage(String documentId);
  Future<double> getUserInputsAverageToday(String documentId);
  Future<bool> checkForInputsToday(String documentId);
  Future<void> addParkingInput(String parkingId, double input);
}