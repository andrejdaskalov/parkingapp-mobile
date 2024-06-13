import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../core/domain/model/parking.dart';
import '../../../core/repository/parking_repository.dart';

part 'contribute_event.dart';

part 'contribute_state.dart';

@injectable
class ContributeBloc extends Bloc<ContributeBlocEvent, ContributeState> {
  final ParkingRepository _parkingRepository;

  ContributeBloc(this._parkingRepository)
      : super(ContributeState(status: ContributionStatus.initial)) {
    on<ContributeEvent>((event, emit) async {
      if (isClosed) return;
      emit(ContributeState(status: ContributionStatus.submitting));
      await _parkingRepository.addParkingInput(event.parkingId, event.input);
      emit(ContributeState(status: ContributionStatus.submitted));
    });

    on<GetContributeDetails>((event, emit) async {
      if (isClosed) return;
      emit(ContributeState(status: ContributionStatus.loading));
      final details = await _parkingRepository.getParkingPlace(event.parkingId);
      emit(ContributeState(status: ContributionStatus.loaded, details: details));
    });
  }
}
