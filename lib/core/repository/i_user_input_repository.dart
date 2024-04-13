import 'package:parkingapp/core/domain/model/user_input.dart';

abstract interface class IUserInputRepository {
  Future<List<UserInput>> listUserInputs();
  Future<UserInput> getUserInput(String documentId);
}
