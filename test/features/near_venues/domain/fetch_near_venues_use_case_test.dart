import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';
import 'package:venues_app/features/near_venues/domain/fetch_near_venues_use_case.dart';

import '../utils/near_venues_responses.dart';

class MockNearVenuesRepository extends Mock implements NearVenuesRepository {}

void main() {
  late MockNearVenuesRepository mockNearVenuesRepository;
  late FetchNearVenuesUseCase fetchNearVenuesUseCase;

  setUp(() {
    mockNearVenuesRepository = MockNearVenuesRepository();
    fetchNearVenuesUseCase = FetchNearVenuesUseCase(mockNearVenuesRepository);
  });

  test('Should return a list of VenueLargeItemEntity', () async {
    when(() => mockNearVenuesRepository.getNearVenues(
          maxItems: 15,
        )).thenAnswer(
      (_) async => NearVenuesResponses.nearVenuesEntityList,
    );

    final result = await fetchNearVenuesUseCase();

    expect(
      result,
      NearVenuesResponses.nearVenuesEntityList,
    );
  });
}
