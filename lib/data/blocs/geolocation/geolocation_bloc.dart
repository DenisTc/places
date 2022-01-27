import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/domain/location.dart';
import 'package:places/services/location_service.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final SharedStorage storage;

  GeolocationBloc({required this.storage}) : super(GeolocationInitial()) {
    on<LoadGeolocationEvent>(
      (event, emit) => _loadGeolocation(emit),
    );
  }

  Future<void> _loadGeolocation(
    Emitter<GeolocationState> emit,
  ) async {
    emit(LoadGeolocationInProgress());

    final permission = await LocationService.checkGeoPermission();

    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      try {
        final position =
            await LocationService.getCurrentUserPosition(timeout: 15);

        await storage.setUserLocation(
          lat: position.latitude,
          lng: position.longitude,
        );

        emit(
          LoadGeolocationSuccess(
            Location(
              lat: position.latitude,
              lng: position.longitude,
            ),
          ),
        );
      } on Exception catch (_) {
        emit(LoadGeolocationError());
      }
    } else {
      emit(LoadGeolocationError());
    }
  }
}
