import 'package:venues_app/core/wrappers/location/location_service.dart';

class LocationServiceMock implements LocationService {
  static const listOfPositions = [
    (60.170187, 24.930599),
    (60.169418, 24.931618),
    (60.169818, 24.932906),
    (60.170005, 24.935105),
    (60.169108, 24.936210),
    (60.168355, 24.934869),
    (60.167560, 24.932562),
    (60.168254, 24.931532),
    (60.169012, 24.930341),
    (60.170085, 24.929569),
  ];

  int _index = -1;

  @override
  Future<(double latitude, double longitude)> getLocation() async {
    _index = (_index + 1) % listOfPositions.length;
    return listOfPositions[_index];
  }
}
