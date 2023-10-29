import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/data/data_sources/venues_local_data_source.dart';
import 'package:venues_app/core/wrappers/preferences/preferences_storage.dart';

class MockPreferencesStorage extends Mock implements PreferencesStorage {}

void main() {
  late PreferencesStorage preferencesStorage;
  late FavoriteVenuesLocalDataSourceImpl venuesLocalDataSourceImpl;

  setUp(() {
    preferencesStorage = MockPreferencesStorage();
    venuesLocalDataSourceImpl = FavoriteVenuesLocalDataSourceImpl(
      storage: preferencesStorage,
    );
  });

  group('getFavoriteVenues - ', () {
    test('Should successfully return a list of favorite venues IDs', () {
      const favoriteVenues = ['1', '2', '3'];

      when(
        () => preferencesStorage.getStringList(any()),
      ).thenReturn(
        favoriteVenues,
      );

      final result = venuesLocalDataSourceImpl.getFavoriteVenues();

      expect(
        result,
        favoriteVenues,
      );
    });

    test('Should return an empty list of favorite venues IDs', () {
      when(
        () => preferencesStorage.getStringList(any()),
      ).thenReturn(
        null,
      );

      final result = venuesLocalDataSourceImpl.getFavoriteVenues();

      expect(
        result,
        [],
      );
    });
  });

  group('saveFavoriteVenue - ', () {
    test('Should successfully save a favorite venue ID', () async {
      const favoriteVenues = ['1', '2', '3'];
      const venueId = '1';

      when(
        () => preferencesStorage.getStringList(any()),
      ).thenReturn(
        favoriteVenues,
      );
      when(
        () => preferencesStorage.setStringList(any(), any()),
      ).thenAnswer(
        (_) => Future.value(true),
      );

      final result = await venuesLocalDataSourceImpl.saveFavoriteVenue(
        venueId,
      );

      expect(
        result,
        true,
      );

      verify(
        () => preferencesStorage.setStringList(
          any(),
          [...favoriteVenues, venueId],
        ),
      );
    });
  });

  group('removeFavoriteVenue - ', () {
    test('Should successfully remove a favorite venue ID', () async {
      const favoriteVenues = ['1', '2', '3'];
      const venueId = '1';

      when(
        () => preferencesStorage.getStringList(any()),
      ).thenReturn(
        favoriteVenues,
      );
      when(
        () => preferencesStorage.setStringList(any(), any()),
      ).thenAnswer(
        (_) => Future.value(true),
      );

      final result = await venuesLocalDataSourceImpl.removeFavoriteVenue(
        venueId,
      );

      expect(
        result,
        true,
      );

      verify(
        () => preferencesStorage.setStringList(
          any(),
          ['2', '3'],
        ),
      );
    });
  });
}
