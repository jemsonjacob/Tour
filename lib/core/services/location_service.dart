import 'package:geolocator/geolocator.dart';
import 'package:tourexplorer/core/exceptions/location_exceptions.dart'
    hide LocationServiceDisabledException;

class LocationService {
  Future<Position> getCurrentLocation() async {
    // Check whether GPS/location service is enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw const LocationServiceDisabledException();
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    // Ask for permission
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw const LocationPermissionDeniedException();
      }
    }

    // Permission permanently denied
    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionPermanentlyDeniedException();
    }

    // Get current position
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
