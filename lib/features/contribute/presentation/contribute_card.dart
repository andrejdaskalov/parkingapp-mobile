import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/features/common_ui/headings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/dependency_injection/injectable_config.dart';
import '../../../core/domain/model/parking.dart';
import '../bloc/contribute_bloc.dart';

class ContributeDetailsCard extends StatefulWidget {
  final String placeId;
  final Function() onDismiss;

  ContributeDetailsCard(
      {Key? key, required this.placeId, required this.onDismiss})
      : super(key: key);

  @override
  _ContributeDetailsCardState createState() => _ContributeDetailsCardState();
}

class _ContributeDetailsCardState extends State<ContributeDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt.get<ContributeBloc>();
        if (!bloc.isClosed) {
          bloc.add(GetContributeDetails(widget.placeId));
        }
        return bloc;
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.up,
        onDismissed: (direction) {
          widget.onDismiss();
        },
        child: Container(
          child: BlocListener<ContributeBloc, ContributeState>(
            listener: (context, state) {
              if (state.status == ContributionStatus.submitted) {
                widget.onDismiss();
              }
            },
            child: BlocBuilder<ContributeBloc, ContributeState>(
              builder: (context, state) {
                if (state.status == ContributionStatus.loading ||
                    state.status == ContributionStatus.submitting) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == ContributionStatus.error) {
                  return Center(child: Text("Грешка"));
                } else if (state.status == ContributionStatus.loaded) {
                  ParkingPlace place = state.details!;
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    child: Card(
                      color: Theme.of(context).colorScheme.background,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TitleHeading(text: place.name),
                                        BoldHeading(text: place.address),
                                        SubtitleHeading(
                                            text: "Колку е зафатен паркингот?"),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ZoneLabel(text: "Зона"),
                                    ZoneHeading(text: place.zone.toString()),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      child: Text(""),
                                      onPressed: () {
                                        context
                                            .read<ContributeBloc>()
                                            .add(ContributeEvent(place.id, 0));
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.lightGreen),
                                      child: Text(""),
                                      onPressed: () {
                                        context.read<ContributeBloc>().add(
                                            ContributeEvent(place.id, 0.25));
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.orange),
                                      child: Text(""),
                                      onPressed: () {
                                        context.read<ContributeBloc>().add(
                                            ContributeEvent(place.id, 0.75));
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Text(""),
                                      onPressed: () {
                                        context
                                            .read<ContributeBloc>()
                                            .add(ContributeEvent(place.id, 1));
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Речиси слободен"),
                                    Text("Речиси преполн"),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else
                  return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
