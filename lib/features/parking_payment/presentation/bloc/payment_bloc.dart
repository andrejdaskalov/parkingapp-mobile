import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:parkingapp/core/domain/model/parking.dart';
import 'package:parkingapp/core/domain/model/parking_payment.dart';
import 'package:parkingapp/core/repository/parking_repository.dart';
import 'package:parkingapp/core/service/sms.dart';
import 'package:parkingapp/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

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
      await _smsService.sendSms(
          event.message + " " + event.parkingPlace.zone.toString(),
          event.recipient, (SMSStatus value) {
            if (value == SMSStatus.error) {
              emit(PaymentState(
                  status: ParkingStatus.error, error: "Грешка при стартување на паркингот"));
            } else {
              emit(PaymentState(status: ParkingStatus.loaded));
            }

          });
      await _paymentService.setCurrentlyPayingParking(
          event.parkingPlace.id, event.startTime);
      await getDetails(event, emit);
    });

    on<StopParking>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      await _smsService.sendSms(
          "S",
          event.recipient, (SMSStatus value) {
            if (value == SMSStatus.error) {
              emit(PaymentState(
                  status: ParkingStatus.error, error: "Грешка при стопирање на паркингот"));
            } else {
              emit(PaymentState(status: ParkingStatus.loaded));
            }

          });
      await _paymentService.clearCurrentlyPayingParking();
      emit(PaymentState(status: ParkingStatus.stopped));
      await getDetails(event, emit);
    });

    on<GetParkingDetails>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      await getDetails(event, emit);
    });

    on<UpdateUserLocationP>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loaded, userPosition: event.position));
    });

    on<ContributeUserInput>((event, emit) async {
      emit(PaymentState(status: ParkingStatus.loading));
      await _parkingRepository.addParkingInput(event.parkingId, event.input);
      emit(PaymentState(status: ParkingStatus.loaded));
    });
  }

  Future<Position> _getCurrentLocation(event, emit) async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      // Handle the case when the user denies the permission
      print('Location permission is denied');
      return Future.error('Location permission is denied');
    }
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
    int cost = getCost(parkingPlace, parkingPaymentDetails);
    emit(PaymentState(
        status: ParkingStatus.loaded,
        currentlyPayingParking: parkingPaymentDetails.parkingPlaceId,
        startTime: parkingPaymentDetails.startTime,
        currentCost: cost.toDouble(),
        parkingZone: parkingPlace.zone));
  }

  int getCost(
      ParkingPlace parkingPlace, ParkingPaymentDetails parkingPaymentDetails) {
    var duration = DateTime.now().difference(parkingPaymentDetails.startTime).inMinutes.toDouble() / 60.0;
    duration = duration < 1 ? 1 : duration;

    return parkingPlace.pricePerHour != null
        ? parkingPlace.pricePerHour! *
            duration.ceil()
        : 0;
  }
}
