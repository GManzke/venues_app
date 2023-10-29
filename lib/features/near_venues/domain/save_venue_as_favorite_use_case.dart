import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';

class SaveVenueAsFavoriteUseCase {
  final NearVenuesRepository repository;

  SaveVenueAsFavoriteUseCase(this.repository);

  void call(String venueID) => repository.saveFavoriteVenue(venueID);
}
