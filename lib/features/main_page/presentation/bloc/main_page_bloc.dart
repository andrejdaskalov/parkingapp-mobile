import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:parkingapp/core/repository/impl/user_input_repository.dart';

import '../../../../core/domain/model/parking.dart';
import '../../../../core/repository/parking_repository.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

@injectable
class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final ParkingRepository _parkingRepository;
  final UserInputRepository _userInputRepository;

  MainPageBloc(this._parkingRepository, this._userInputRepository) : super( MainPageState(status: Status.loading)){
    on<GetPlaces>(_getPlaces);

    on<SelectPlace>(_getPlaceDetails);
  }


    Future<void> _getPlaces(GetPlaces event, Emitter<MainPageState> emit) async {
    print('User inputs fetching...');
    final userInputs = await _userInputRepository.listUserInputs();
    print('User inputs fetched: $userInputs');
    print('Fetching places...');
    try {
      final places = await _parkingRepository.listParkings();
      print('Places fetched: $places');

      emit(state.copyWith(status: Status.loaded, places: places));
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: e.toString()));
    }
  }



  Future<void> _getPlaceDetails(SelectPlace event, Emitter<MainPageState> emit) async {
    emit(state.copyWith(selectedPlace: event.place));
    // emit(state.copyWith(status: Status.loaded, selectedPlace: null));
  }
}
