import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/data/data_sources/venues_local_data_source.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';

abstract class NearVenuesRepository {
  Future<List<VenueLargeItemEntity>> getNearVenues();

  List<String> getFavoriteVenues();

  void removeFavoriteVenue(String venueId);

  void saveFavoriteVenue(String venueId);
}

class NearVenuesRepositoryImpl implements NearVenuesRepository {
  final NearVenuesDataSource nearVenuesSource;
  final UserLocationDataSource userLocationSource;
  final VenuesLocalDataSource venuesLocalSource;

  NearVenuesRepositoryImpl({
    required this.nearVenuesSource,
    required this.userLocationSource,
    required this.venuesLocalSource,
  });

  @override
  Future<List<VenueLargeItemEntity>> getNearVenues() async {
    final (lat, lon) = await userLocationSource.getLocation();

    final venues = await nearVenuesSource.getNearVenues(
      lat: lat,
      lon: lon,
    );

    return venues;
  }

  @override
  List<String> getFavoriteVenues() {
    return venuesLocalSource.getFavoriteVenues();
  }

  @override
  void saveFavoriteVenue(String venueId) =>
      venuesLocalSource.saveFavoriteVenue(venueId);

  @override
  void removeFavoriteVenue(String venueId) =>
      venuesLocalSource.removeFavoriteVenue(venueId);
}
