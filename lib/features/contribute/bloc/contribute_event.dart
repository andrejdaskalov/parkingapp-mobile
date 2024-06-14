part of 'contribute_bloc.dart';

class ContributeBlocEvent {}

class ContributeEvent extends ContributeBlocEvent{
  final String parkingId;
  final double input;

  ContributeEvent(this.parkingId, this.input);
}

class GetContributeDetails extends ContributeBlocEvent {
  final String parkingId;

  GetContributeDetails(this.parkingId);
}
