import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';
import 'package:parkingapp/features/parking_payment/presentation/stop_parking_button.dart';


class ParkingPaymentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PaymentBloc>().add(GetParkingDetails());
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.status == ParkingStatus.loading) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: const CircularProgressIndicator()),
          );
        } else if (state.currentlyPayingParking == null) {
          return Padding(
              padding: MediaQuery.of(context).padding + EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: LargeBoldHeading(text: "Нема активен паркинг"));
        } else if (state.status == ParkingStatus.error) {
          return Padding(
              padding: MediaQuery.of(context).padding + EdgeInsets.all(8.0),
              child: LargeBoldHeading(text: state.error ?? "Грешка"));
        } else if (state.status == ParkingStatus.stopped) {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
          return Container();
        } else
          return Scaffold(
            floatingActionButton: Container(
              padding:
                  MediaQuery.of(context).padding + const EdgeInsets.all(8.0),
              child: StopParkingButton(
                onPressed: () {
                  context.read<PaymentBloc>().add(StopParking("077700891"));
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            body: Container(
              padding:
                  MediaQuery.of(context).padding + const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LargeBoldHeading(text: "Активен паркинг:"),
                      LargeBoldHeading(text: state.parkingZone ?? ''),
                    ],
                  ),
                  SubtitleHeading(text: "Почеток: ${state.startTime?.hour.toString().padLeft(2, '0')}:${state.startTime?.minute.toString().padLeft(2, '0')}"),
                  SubtitleHeading(
                      text:
                          "Време поминато: "
                              "${Duration(seconds: DateTime.now().difference(state.startTime!).inSeconds).inMinutes} минути"),
                  SubtitleHeading(text: "Цена: ${state.currentCost} ден."),
                ],
              ),
            ),
          );
      },
    );
  }
}
