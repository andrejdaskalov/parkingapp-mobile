import 'package:injectable/injectable.dart';
import 'package:parkingapp/core/domain/model/user_input.dart';
import 'package:parkingapp/core/repository/impl/parking_repository_prod.dart';

import '../../api/parking_api.dart';
import '../parking_repository.dart';
import '../i_user_input_repository.dart';

@injectable
class UserInputRepository implements IUserInputRepository{

  final ParkingApi _parkingApi;
  final ParkingRepository parkingRepository;

  UserInputRepository(this._parkingApi, this.parkingRepository);

  Future<List<UserInput>> listUserInputs() async {
    List<UserInput> userInputsList = [];

    await _parkingApi.listUserInputs().then((userInputsNetworkList) async {
      for (var userInputNetwork in userInputsNetworkList) {
        final parkingPlace = await parkingRepository.getParkingPlace(userInputNetwork.parking_id);
        final userInput = UserInput.fromNetwork(userInputNetwork, parkingPlace);
        userInputsList.add(userInput);
      }
    });

    return userInputsList;
  }


  @override
  Future<UserInput> getUserInput(String documentId) async {
    final userInputNetwork = await _parkingApi.getUserInput(documentId);
    final parkingPlace = await parkingRepository.getParkingPlace(userInputNetwork.parking_id);
    return UserInput.fromNetwork(userInputNetwork, parkingPlace);
  }


}