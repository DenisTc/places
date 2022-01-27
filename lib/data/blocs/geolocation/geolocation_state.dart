part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class LoadGeolocationInProgress extends GeolocationState {}

class LoadGeolocationSuccess extends GeolocationState {
  final Location userLocation;

  const LoadGeolocationSuccess(this.userLocation);

  @override
  List<Object> get props => [userLocation];
}

class LoadGeolocationError extends GeolocationState {}

class LoadUserGeolocationSuccess extends GeolocationState {
  final Location userLocation;

  const LoadUserGeolocationSuccess(this.userLocation);

  @override
  List<Object> get props => [userLocation];
}

class LoadUserGeolocationError extends GeolocationState {}
