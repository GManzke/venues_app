import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';
import 'package:venues_app/features/near_venues/domain/save_venue_as_favorite_use_case.dart';

class MockNearVenuesRepository extends Mock implements NearVenuesRepository {}

void main() {
  late MockNearVenuesRepository repository;
  late SaveVenueAsFavoriteUseCase useCase;

  setUp(() {
    repository = MockNearVenuesRepository();
    useCase = SaveVenueAsFavoriteUseCase(repository);
  });

  test('Should save a venue as favorite', () {
    const venueID = '1';

    useCase(venueID);

    verify(() => repository.saveFavoriteVenue(venueID));
    verifyNoMoreInteractions(repository);
  });
}
