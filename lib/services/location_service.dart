import 'package:geolocator/geolocator.dart';
import 'package:places/data/storage/shared_storage.dart';

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
}
