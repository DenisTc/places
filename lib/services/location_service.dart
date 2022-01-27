import 'package:geolocator/geolocator.dart';
import 'package:places/data/storage/shared_storage.dart';
import 'package:places/ui/res/constants.dart' as constants;

class LocationService {
  // Function for determining the availability status of geolocation on the device
  static Future<LocationPermission> checkGeoPermission() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  // Function for getting coordinates
  static Future<Position> getCurrentUserPosition({required int timeout}) async {
    final storage = SharedStorage();

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(
      Duration(seconds: timeout),
    );

    await storage.setUserLocation(
      lat: currentPosition.latitude,
      lng: currentPosition.longitude,
    );

    return currentPosition;
  }

  static Future<Position> getLastKnownUserPosition() async {
    final permission = await checkGeoPermission();
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      return await Geolocator.getLastKnownPosition() ??
          Position(
            latitude: constants.defaultLocation.lat,
            longitude: constants.defaultLocation.lng,
            heading: 0.0,
            speed: 0.0,
            accuracy: 0.0,
            speedAccuracy: 0.0,
            altitude: 0.0,
            timestamp: DateTime.now(),
          );
    }

    return Position(
      latitude: constants.defaultLocation.lat,
      longitude: constants.defaultLocation.lng,
      heading: 0.0,
      speed: 0.0,
      accuracy: 0.0,
      speedAccuracy: 0.0,
      altitude: 0.0,
      timestamp: DateTime.now(),
    );
  }
}
