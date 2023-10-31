import 'package:venues_app/core/wrappers/location/location_service.dart';

abstract class UserLocationDataSource {
  Future<Location> getLocation();

  double getDistanceInMeters(Location origin, Location destination);
}

class UserLocationDataSourceImpl implements UserLocationDataSource {
  final LocationService userLocation;

  UserLocationDataSourceImpl(this.userLocation);

  @override
  Future<Location> getLocation() => userLocation.getLocation();

  @override
  double getDistanceInMeters(Location origin, Location destination) =>
      userLocation.getDistanceInMeters(origin, destination);
}
