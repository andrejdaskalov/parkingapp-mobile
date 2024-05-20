part of 'main_page_bloc.dart';

final class MainPageState extends Equatable{
  final Status status;
  final List<ParkingPlace> places;
  final String error;
  final ParkingPlace? selectedPlace;
  final Position? userPosition;

  const MainPageState({required this.status, this.places = const [], this.error = '', this.selectedPlace, this.userPosition});

  MainPageState copyWith({
    Status? status,
    List<ParkingPlace>? places,
    String? error,
    ParkingPlace? selectedPlace,
    Position? userPosition,
  }) {
    return MainPageState(
      status: status ?? this.status,
      places: places ?? this.places,
      error: error ?? this.error,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      userPosition: userPosition ?? this.userPosition,
    );
  }

  @override
  List<Object?> get props => [status, places, error];
}


enum Status { loading, loaded, error }
