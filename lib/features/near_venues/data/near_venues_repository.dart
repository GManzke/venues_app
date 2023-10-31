import 'package:venues_app/core/data/data_sources/favorite_venues_local_data_source.dart';
import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';

abstract class NearVenuesRepository {
  Future<List<VenueLargeItemEntity>> getNearVenues({
    required int maxItems,
  });

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
  Future<List<VenueLargeItemEntity>> getNearVenues({
    required int maxItems,
  }) async {
    final currentLocation = await locationDataSource.getLocation();

    final favoriteIds = favoritesDataSource.getFavoriteVenues();

    final venues = List.of(await nearVenuesSource.getNearVenues(
      maxItems: maxItems,
      location: currentLocation,
    ));

    if (venues.isEmpty) {
      return [];
    }

    return venues
        .map((e) => e.toEntity().copyWith(
              isFavorite: favoriteIds.contains(e.id),
              distance: locationDataSource
                  .getDistanceInMeters(
                    currentLocation,
                    e.info.location,
                  )
                  .round(),
            ))
        .toList()
      ..sort((a, b) => a.distance!.compareTo(b.distance!));
  }

  @override
  void saveFavoriteVenue(String venueId) =>
      favoritesDataSource.saveFavoriteVenue(venueId);

  @override
  void removeFavoriteVenue(String venueId) =>
      favoritesDataSource.removeFavoriteVenue(venueId);
}
