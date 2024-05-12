import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:parkingapp/core/domain/model/parking.dart';
import 'package:parkingapp/core/domain/model/parking_payment.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';
import 'package:parkingapp/core/service/sms.dart';

import '../../service/payment_service.dart';

part 'payment_event.dart';

part 'payment_state.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentService _paymentService;
  final ParkingRepository _parkingRepository;
  final SMSService _smsService;

  PaymentBloc(
    this._paymentService,
    this._parkingRepository,
    this._smsService,
  ) : super(PaymentState(status: ParkingStatus.loading)) {
    on<StartParking>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      SMSStatus smsStatus = await _smsService.sendSms(
          event.message + " " + event.parkingPlace.zone.toString(),
          event.recipient);
      if (smsStatus == SMSStatus.error) {
        emit(PaymentState(
            status: ParkingStatus.error, error: "Грешка при стартување на паркингот"));
        return;
      }
      await _paymentService.setCurrentlyPayingParking(
          event.parkingPlace.id, event.startTime);
      await getDetails(event, emit);
    });

    on<StopParking>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      SMSStatus smsStatus = await _smsService.sendSms(
          "S",
          event.recipient);
      if (smsStatus == SMSStatus.error) {
        emit(PaymentState(
            status: ParkingStatus.error, error: "Грешка при стопирање на паркингот"));
        return;
      }
      await _paymentService.clearCurrentlyPayingParking();
      emit(PaymentState(status: ParkingStatus.stopped));
      await getDetails(event, emit);
    });

    on<GetParkingDetails>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      await getDetails(event, emit);
    });
  }

  Future<void> getDetails(event, emit) async {
    ParkingPaymentDetails? parkingPaymentDetails =
        await _paymentService.getCurrentlyPayingParking();
    if (parkingPaymentDetails == null) {
      emit(PaymentState(
        status: ParkingStatus.loaded,
        currentlyPayingParking: null,
      ));
      return;
    }
    ParkingPlace parkingPlace = await _parkingRepository
        .getParkingPlace(parkingPaymentDetails.parkingPlaceId);
    double cost = getCost(parkingPlace, parkingPaymentDetails);
    emit(PaymentState(
        status: ParkingStatus.loaded,
        currentlyPayingParking: parkingPaymentDetails.parkingPlaceId,
        startTime: parkingPaymentDetails.startTime,
        currentCost: cost,
        parkingZone: parkingPlace.zone));
  }

  double getCost(
      ParkingPlace parkingPlace, ParkingPaymentDetails parkingPaymentDetails) {
    return parkingPlace.pricePerHour != null
        ? parkingPlace.pricePerHour! *
            (DateTime.now()
                    .difference(parkingPaymentDetails.startTime)
                    .inMinutes /
                60)
        : 0;
  }
}
