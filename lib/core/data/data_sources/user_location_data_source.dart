import 'package:venues_app/core/wrappers/location/location_service.dart';

abstract class UserLocationDataSource {
  Future<(double latitude, double longitude)> getLocation();
}

class UserLocationDataSourceImpl implements UserLocationDataSource {
  final LocationService userLocation;

  UserLocationDataSourceImpl(this.userLocation);

  @override
  Future<(double latitude, double longitude)> getLocation() async =>
      userLocation.getLocation();
}
