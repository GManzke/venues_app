import 'package:geolocator/geolocator.dart' hide Position;
import 'package:venues_app/core/wrappers/location/location_service.dart';

class LocationServiceMock implements LocationService {
  static const listOfPositions = [
    (latitude: 60.170187, longitude: 24.930599),
    (latitude: 60.169418, longitude: 24.931618),
    (latitude: 60.169818, longitude: 24.932906),
    (latitude: 60.170005, longitude: 24.935105),
    (latitude: 60.169108, longitude: 24.936210),
    (latitude: 60.168355, longitude: 24.934869),
    (latitude: 60.167560, longitude: 24.932562),
    (latitude: 60.168254, longitude: 24.931532),
    (latitude: 60.169012, longitude: 24.930341),
    (latitude: 60.170085, longitude: 24.929569),
  ];

  int _index = -1;

  @override
  Future<Location> getLocation() async {
    _index = (_index + 1) % listOfPositions.length;
    return listOfPositions[_index];
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
