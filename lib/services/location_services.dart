import 'package:places/ui/res/constants.dart' as constants;
import 'package:geolocator/geolocator.dart';
import 'package:places/domain/location.dart';

class LocationServices {
  Future<Location> getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return constants.userLocation;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return constants.userLocation;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(const Duration(seconds: 5));

    return Location(lat: position.latitude, lng: position.longitude);
  }
}
