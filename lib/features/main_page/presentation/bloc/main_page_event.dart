part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

final class GetPlaces extends MainPageEvent {}

final class SelectPlace extends MainPageEvent {
  final ParkingPlace place;

  SelectPlace(this.place);
}