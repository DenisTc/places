part of 'geolocation_bloc.dart';

class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadGeolocationEvent extends GeolocationEvent {}

class LoadUserGeolocationEvent extends GeolocationEvent {}
