import 'package:equatable/equatable.dart';

class Location extends Equatable{

  const Location(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];

}