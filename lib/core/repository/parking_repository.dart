import '../domain/model/parking.dart';

abstract interface class ParkingRepository {
  Future<List<ParkingPlace>> listParkings();
  Future<ParkingPlace> getParkingPlace(String documentId);
}
