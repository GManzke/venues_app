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

  test('Should return the current location', () async {
    when(() => locationService.getLocation()).thenAnswer(
      (_) async => (1.0, 2.0),
    );

    final (latitude, longitude) =
        await userLocationDataSourceImpl.getLocation();

    expect(latitude, 1.0);
    expect(longitude, 2.0);
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
}
