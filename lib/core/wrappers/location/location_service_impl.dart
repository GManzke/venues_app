import 'package:geolocator/geolocator.dart';
import 'package:venues_app/core/wrappers/location/errors/location_service_errors.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<(double latitude, double longitude)> getLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw LocationNotEnabledException();
    }

    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      throw LocationPermissionNotGrantedException();
    }

    if (await Geolocator.checkPermission() ==
        LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return (position.latitude, position.longitude);
  }
}
