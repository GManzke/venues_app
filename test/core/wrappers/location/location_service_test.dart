import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/core/wrappers/location/location_service_mock.dart';

void main() {
  late LocationServiceMock locationMock;

  setUp(() {
    locationMock = LocationServiceMock();
  });

  test(
      'Should loop through the list of positions '
      'returning the next position', () async {
    for (var element in LocationServiceMock.listOfPositions) {
      expect(locationMock.getLocation(), completion(element));
    }

    expect(
      locationMock.getLocation(),
      completion(
        LocationServiceMock.listOfPositions[0],
      ),
    );
  });
}
