
import '../domain/parking.dart';

abstract interface class ParkingApi {
  Future<List<ParkingPlace>> listParkings();

  Future<ParkingPlace> getParking(String id);
}