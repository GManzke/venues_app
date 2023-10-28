import 'package:venues_app/core/wrappers/preferences/preferences_storage.dart';

abstract class VenuesLocalDataSource {
  List<String> getFavoriteVenues();

  Future<bool> removeFavoriteVenue(String venueId);

  Future<bool> saveFavoriteVenue(String venueId);
}

class VenuesLocalDataSourceImpl implements VenuesLocalDataSource {
  final PreferencesStorage storage;

  VenuesLocalDataSourceImpl({
    required this.storage,
  });

  static const _favoriteVenuesKey = '81e322a5-8dd0-436c-b6db-c940844ff131';

  @override
  List<String> getFavoriteVenues() {
    final favoriteVenues = storage.getStringList(
      _favoriteVenuesKey,
    );

    return favoriteVenues ?? [];
  }

  @override
  Future<bool> saveFavoriteVenue(String venueId) {
    final favoriteVenues = [...getFavoriteVenues(), venueId];

    return storage.setStringList(
      _favoriteVenuesKey,
      favoriteVenues,
    );
  }

  @override
  Future<bool> removeFavoriteVenue(String venueId) {
    final favoriteVenues = [...getFavoriteVenues()]..remove(venueId);

    return storage.setStringList(
      _favoriteVenuesKey,
      favoriteVenues,
    );
  }
}
