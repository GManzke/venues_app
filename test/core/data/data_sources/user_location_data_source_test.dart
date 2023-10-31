import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';

class MockLocationService extends Mock implements LocationService {}

void main() {
  late LocationService locationService;
  late UserLocationDataSourceImpl userLocationDataSourceImpl;

  setUp(() {
    locationService = MockLocationService();
    userLocationDataSourceImpl = UserLocationDataSourceImpl(locationService);
  });

  group('getLocation - ', () {
    test('Should return the current location', () async {
      when(() => locationService.getLocation()).thenAnswer(
        (_) async => (latitude: 1.0, longitude: 2.0),
      );

      final (latitude: lat, longitude: long) =
          await userLocationDataSourceImpl.getLocation();

      expect(lat, 1.0);
      expect(long, 2.0);
      verify(() => locationService.getLocation()).called(1);
    });

    test('Should throw an exception if the location service fails', () async {
      when(() => locationService.getLocation()).thenThrow(Exception());

      expect(
        () async => await userLocationDataSourceImpl.getLocation(),
        throwsA(isA<Exception>()),
      );
      verify(() => locationService.getLocation()).called(1);
    });
  });

  group('getDistanceInMeters - ', () {
    const origin = (latitude: 1.0, longitude: 2.0);
    const destination = (latitude: 3.0, longitude: 4.0);

    test('Should return the distance in meters', () {
      when(() => locationService.getDistanceInMeters(origin, destination))
          .thenReturn(1000);

      final distance = userLocationDataSourceImpl.getDistanceInMeters(
        origin,
        destination,
      );

      expect(distance, 1000);
    });

    test('Should throw an exception if the location service fails', () async {
      when(() => locationService.getDistanceInMeters(origin, destination))
          .thenThrow(Exception());

      expect(
        () => userLocationDataSourceImpl.getDistanceInMeters(
          origin,
          destination,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
