part of 'main_page_bloc.dart';

final class MainPageState extends Equatable{
  final Status status;
  final List<ParkingPlace> places;
  final String error;

  const MainPageState({required this.status, this.places = const [], this.error = ''});

  MainPageState copyWith({
    Status? status,
    List<ParkingPlace>? places,
    String? error,
  }) {
    return MainPageState(
      status: status ?? this.status,
      places: places ?? this.places,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, places, error];
}


enum Status { loading, loaded, error }
