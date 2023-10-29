import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';

class RemoveVenueFromFavoritesUseCase {
  final NearVenuesRepository repository;

  RemoveVenueFromFavoritesUseCase(this.repository);

  void call(String venueID) => repository.removeFavoriteVenue(venueID);
}
