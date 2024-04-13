import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:parkingapp/core/domain/parking.dart';

import '../../service/payment_service.dart';

part 'payment_event.dart';
part 'payment_state.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentService _paymentService;
  PaymentBloc(
      this._paymentService,
      ) : super(PaymentState(status: ParkingStatus.loading)) {
    on<StartParking>((event, emit) {
      emit(PaymentState(status: ParkingStatus.loading));
      // _paymentService.setCurrentlyPayingParking(event.parkingPlace.id);
      emit(PaymentState(status: ParkingStatus.loaded));
    });
  }


}
