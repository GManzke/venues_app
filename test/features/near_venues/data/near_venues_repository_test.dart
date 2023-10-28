import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';

import '../utils/near_venues_responses.dart';

class MockNearVenuesDataSource extends Mock implements NearVenuesDataSource {}

class MockUserLocationDataSource extends Mock
    implements UserLocationDataSource {}

void main() {
  late NearVenuesDataSource nearVenuesDataSource;
  late UserLocationDataSource userLocationDataSource;
  late NearVenuesRepositoryImpl nearVenuesRepositoryImpl;

  setUp(() {
    nearVenuesDataSource = MockNearVenuesDataSource();
    userLocationDataSource = MockUserLocationDataSource();
    nearVenuesRepositoryImpl = NearVenuesRepositoryImpl(
      nearVenuesSource: nearVenuesDataSource,
      userLocationSource: userLocationDataSource,
    );
  });

  group('getNearVenues - ', () {
    test('Should successfully return a list of VenueLargeItemEntity', () async {
      const location = (lat: 1.0, lon: 2.0);

      when(
        () => userLocationDataSource.getLocation(),
      ).thenAnswer((_) async => (location.lat, location.lon));
      when(
        () => nearVenuesDataSource.getNearVenues(
          lat: location.lat,
          lon: location.lon,
        ),
      ).thenAnswer(
        (_) => Future.value(
          NearVenuesResponses.nearVenuesModelList,
        ),
      );

      final result = await nearVenuesRepositoryImpl.getNearVenues();

      expect(
        result,
        NearVenuesResponses.nearVenuesModelList,
      );
      expect(
        result,
        isA<List<VenueLargeItemEntity>>(),
      );

      verify(
        () => userLocationDataSource.getLocation(),
      );
      verify(
        () => nearVenuesDataSource.getNearVenues(
          lat: location.lat,
          lon: location.lon,
        ),
      );
      verifyNoMoreInteractions(userLocationDataSource);
      verifyNoMoreInteractions(nearVenuesDataSource);
    });
  });
}
