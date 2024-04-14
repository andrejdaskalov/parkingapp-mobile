import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/core/dependency_injection/injectable_config.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:parkingapp/features/parking_payment/presentation/bloc/payment_bloc.dart';

class PaymentStatusButton extends StatefulWidget {
  @override
  State<PaymentStatusButton> createState() => _PaymentStatusButtonState();
}

class _PaymentStatusButtonState extends State<PaymentStatusButton> {
  @override
  Widget build(BuildContext context) {
    context.read<PaymentBloc>().add(GetParkingDetails());
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.status == ParkingStatus.loading) {
          return const CircularProgressIndicator();
        }
        if (state.currentlyPayingParking == null) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme
                .of(context)
                .primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(state.parkingZone ?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary)),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(state.currentCost!.toInt().toString() + ' ден.',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary)),
              ),
            ],
          ),
        );
      },
    );
  }
}
