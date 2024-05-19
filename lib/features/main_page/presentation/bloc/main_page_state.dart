part of 'main_page_bloc.dart';

final class MainPageState extends Equatable{
  final Status status;
  final List<ParkingPlace> places;
  final String error;
  final ParkingPlace? selectedPlace;
  final Availability? availability;

  const MainPageState({this.availability, required this.status, this.places = const [], this.error = '', this.selectedPlace,});

  MainPageState copyWith({
    Status? status,
    List<ParkingPlace>? places,
    String? error,
    ParkingPlace? selectedPlace,
    Availability? availability,
  }) {
    return MainPageState(
      status: status ?? this.status,
      places: places ?? this.places,
      error: error ?? this.error,
      selectedPlace: selectedPlace ?? this.selectedPlace,
      availability: availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props => [status, places, error, availability, selectedPlace];
}


enum Status { loading, loaded, error }
