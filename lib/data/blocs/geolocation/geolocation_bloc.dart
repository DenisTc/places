import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/location.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final SharedStorage storage;

  GeolocationBloc({required this.storage}) : super(GeolocationInitial()) {
    on<LoadGeolocationEvent>(
      (event, emit) => _loadGeolocation(event, emit),
    );

    on<LoadUserGeolocationEvent>(
      (event, emit) => _loadUserGeolocation(event, emit),
    );
  }

  Future<void> _loadGeolocation(
    LoadGeolocationEvent event,
    Emitter<GeolocationState> emit,
  ) async {
    final permission = await checkGeoPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      try {
        Position position = await getCurrentUserPosition(timeout: 15);

        storage.setUserLocation(
          lat: position.latitude,
          lng: position.longitude,
        );

        debugPrint('Geolocation determine success!');

        emit(
          LoadGeolocationSuccess(
            Location(
              lat: position.latitude,
              lng: position.longitude,
            ),
          ),
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    } else {
      emit(LoadGeolocationError());
    }
  }

  Future<void> _loadUserGeolocation(
    LoadUserGeolocationEvent event,
    Emitter<GeolocationState> emit,
  ) async {
    final permission = await checkGeoPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      try {
        Position position = await getCurrentUserPosition(timeout: 15);

        emit(
          LoadUserGeolocationSuccess(
            Location(
              lat: position.latitude,
              lng: position.longitude,
            ),
          ),
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    } else {
      emit(LoadUserGeolocationError());
    }
  }
}

// Function for determining the availability status of geolocation on the device
Future<LocationPermission> checkGeoPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  return permission;
}

// Function for getting coordinates
Future<Position> getCurrentUserPosition({required int timeout}) async {
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  ).timeout(
    Duration(seconds: timeout),
  );
}
