import 'package:geolocator/geolocator.dart';
import 'package:venues_app/core/wrappers/location/errors/location_service_errors.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';

/// Implementation of [LocationService] using [Geolocator]
/// to get a better idea of an ideal [LocationServiceMock]
class LocationServiceImpl implements LocationService {
  @override
  Future<Location> getLocation() async {
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

    final Position(latitude: lat, longitude: long) =
        await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return (latitude: lat, longitude: long);
  }

  @override
  double getDistanceInMeters(Location origin, Location destination) =>
      Geolocator.distanceBetween(
        origin.latitude,
        origin.longitude,
        destination.latitude,
        destination.longitude,
      );
}
