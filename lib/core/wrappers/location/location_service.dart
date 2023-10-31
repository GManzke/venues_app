typedef Location = ({double latitude, double longitude});

abstract class LocationService {
  Future<Location> getLocation();

  double getDistanceInMeters(Location origin, Location destination);
}
