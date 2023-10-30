import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/features/near_venues/domain/fetch_near_venues_use_case.dart';
import 'package:venues_app/features/near_venues/domain/remove_venue_from_favorites_use_case.dart';
import 'package:venues_app/features/near_venues/domain/save_venue_as_favorite_use_case.dart';
import 'package:venues_app/features/near_venues/presentation/controller/near_venues_cubit.dart';

import '../../utils/near_venues_responses.dart';

class MockFetchNearVenuesUseCase extends Mock
    implements FetchNearVenuesUseCase {}

class MockSaveVenueAsFavoriteUseCase extends Mock
    implements SaveVenueAsFavoriteUseCase {}

class MockRemoveVenueFromFavoritesUseCase extends Mock
    implements RemoveVenueFromFavoritesUseCase {}

void main() {
  late MockFetchNearVenuesUseCase mockFetchNearVenuesUseCase;
  late MockSaveVenueAsFavoriteUseCase mockSaveVenueAsFavoriteUseCase;
  late MockRemoveVenueFromFavoritesUseCase mockRemoveVenueFromFavoritesUseCase;
  late NearVenuesCubit nearVenuesCubit;

  setUp(() {
    mockFetchNearVenuesUseCase = MockFetchNearVenuesUseCase();
    mockSaveVenueAsFavoriteUseCase = MockSaveVenueAsFavoriteUseCase();
    mockRemoveVenueFromFavoritesUseCase = MockRemoveVenueFromFavoritesUseCase();
    nearVenuesCubit = NearVenuesCubit(
      fetchNearVenuesUseCase: mockFetchNearVenuesUseCase,
      saveFavoriteVenueUseCase: mockSaveVenueAsFavoriteUseCase,
      removeFavoriteVenueUseCase: mockRemoveVenueFromFavoritesUseCase,
    );
  });

  tearDown(() {
    nearVenuesCubit.close();
  });

  blocTest(
    'Should have NearVenuesLoadingState as initial state',
    build: () => nearVenuesCubit,
    verify: (cubit) {
      expect(cubit.state, NearVenuesLoadingState());
    },
  );

  group('fetchData - ', () {
    blocTest(
      'Should have NearVenuesLoadedState as state when fetchData is called',
      build: () {
        when(() => mockFetchNearVenuesUseCase()).thenAnswer(
          (_) async => NearVenuesResponses.nearVenuesEntityList,
        );

        return nearVenuesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NearVenuesLoadingState(),
        NearVenuesLoadedState(
          venuesList: NearVenuesResponses.nearVenuesEntityList,
        ),
      ],
    );

    blocTest(
      'Should have NearVenuesErrorState as state when fetchData throws an exception',
      build: () {
        when(() => mockFetchNearVenuesUseCase()).thenThrow(
          Exception(),
        );
        return nearVenuesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NearVenuesLoadingState(),
        NearVenuesErrorState(),
      ],
    );
  });

  group('toggleVenueFavorite - ', () {
    blocTest<NearVenuesCubit, NearVenuesState>(
      'Should have NearVenuesLoadedState updated with favorite venue '
      'when toggleVenueFavorite is called',
      build: () => nearVenuesCubit,
      seed: () => NearVenuesLoadedState(
        venuesList: NearVenuesResponses.nearVenuesEntityList,
      ),
      act: (cubit) {
        cubit.toggleVenueFavorite(0);
      },
      expect: () => [
        NearVenuesLoadedState(
          venuesList: NearVenuesResponses.nearVenuesEntityListWithFavorite,
        ),
      ],
    );

    blocTest<NearVenuesCubit, NearVenuesState>(
      'Should have NearVenuesLoadedState updated without favorite venue '
      'when toggleVenueFavorite is called',
      build: () => nearVenuesCubit,
      seed: () => NearVenuesLoadedState(
        venuesList: NearVenuesResponses.nearVenuesEntityListWithFavorite,
      ),
      act: (cubit) {
        cubit.toggleVenueFavorite(0);
      },
      expect: () => [
        NearVenuesLoadedState(
          venuesList: NearVenuesResponses.nearVenuesEntityList,
        ),
      ],
    );
  });
}
