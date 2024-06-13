part of 'contribute_bloc.dart';

class ContributeState {
  final ContributionStatus status;
  final String? error;
  final ParkingPlace? details;

  ContributeState({this.details,
    required this.status,
    this.error,
  });

  ContributeState copyWith({
    ContributionStatus? status,
    String? error,
  }) {
    return ContributeState(
      status: status ?? this.status,
      error: error ?? this.error,
      details: details ?? this.details,
    );
  }
}

enum ContributionStatus {
  initial,
  loading,
  loaded,
  submitting,
  submitted,
  error,
}

