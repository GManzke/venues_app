import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';
import 'package:venues_app/features/near_venues/domain/remove_venue_from_favorites_use_case.dart';

class MockNearVenuesRepository extends Mock implements NearVenuesRepository {}

void main() {
  late MockNearVenuesRepository repository;
  late RemoveVenueFromFavoritesUseCase useCase;

  setUp(() {
    repository = MockNearVenuesRepository();
    useCase = RemoveVenueFromFavoritesUseCase(repository);
  });

  test('Should remove a venue from favorites', () {
    const venueID = '1';

    useCase(venueID);

    verify(() => repository.removeFavoriteVenue(venueID));
    verifyNoMoreInteractions(repository);
  });
}
