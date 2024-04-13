import '../domain/model/parking.dart';

abstract interface class IParkingRepository {
  Future<List<ParkingPlace>> listParkings();
  Future<ParkingPlace> getParkingPlace(String documentId);
}
