import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';
import 'package:venues_app/features/near_venues/domain/fetch_favorite_venues_use_case.dart';

class MockNearVenuesRepository extends Mock implements NearVenuesRepository {}

void main() {
  late MockNearVenuesRepository repository;
  late FetchFavoriteVenuesIDUseCase useCase;

  setUp(() {
    repository = MockNearVenuesRepository();
    useCase = FetchFavoriteVenuesIDUseCase(repository);
  });

  test('Should return a list of favorite venues IDs', () {
    final favoriteVenuesID = ['1', '2', '3'];

    when(() => repository.getFavoriteVenues()).thenReturn(
      favoriteVenuesID,
    );

    final result = useCase();

    expect(result, favoriteVenuesID);
    verify(() => repository.getFavoriteVenues());
    verifyNoMoreInteractions(repository);
  });
}
