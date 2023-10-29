import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/data/data_sources/venues_local_data_source.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';

abstract class NearVenuesRepository {
  Future<List<VenueLargeItemEntity>> getNearVenues();

  void removeFavoriteVenue(String venueId);

  void saveFavoriteVenue(String venueId);
}

class NearVenuesRepositoryImpl implements NearVenuesRepository {
  final NearVenuesDataSource nearVenuesSource;
  final UserLocationDataSource locationDataSource;
  final FavoriteVenuesLocalDataSource favoritesDataSource;

  NearVenuesRepositoryImpl({
    required this.nearVenuesSource,
    required this.locationDataSource,
    required this.favoritesDataSource,
  });

  @override
  Future<List<VenueLargeItemEntity>> getNearVenues() async {
    final (lat, lon) = await locationDataSource.getLocation();

    var venues =
        List<VenueLargeItemEntity>.of(await nearVenuesSource.getNearVenues(
      lat: lat,
      lon: lon,
    ));

    final favoriteIds = favoritesDataSource.getFavoriteVenues();

    for (var id in favoriteIds) {
      final index = venues.indexWhere((element) => element.info.id == id);
      if (index == -1) continue;

      venues[index] = venues[index].copyWith(isFavorite: true);
    }

    return venues;
  }

  @override
  void saveFavoriteVenue(String venueId) =>
      favoritesDataSource.saveFavoriteVenue(venueId);

  @override
  void removeFavoriteVenue(String venueId) =>
      favoritesDataSource.removeFavoriteVenue(venueId);
}
