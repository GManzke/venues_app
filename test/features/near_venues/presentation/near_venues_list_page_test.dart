import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/core/wrappers/injection/injection_service.dart';
import 'package:venues_app/features/near_venues/presentation/controller/near_venues_cubit.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_error.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loaded.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loading.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_page.dart';

import '../utils/mock_image_http.dart';

class MockNearVenuesCubit extends MockCubit<NearVenuesState>
    implements NearVenuesCubit {}

void main() {
  late MockNearVenuesCubit mockNearVenuesCubit;

  final expectedVenueList = List.generate(5, (index) {
    return VenueLargeItemEntity(
      info: VenueInfoEntity(
        id: '$index',
        name: 'Venue $index',
        shortDescription: 'Venue $index description',
      ),
      isFavorite: false,
      image: const VenueImageEntity(url: 'www.example.com'),
    );
  });

  Future<void> createWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NearVenuesListPage(),
        ),
      ),
    );
  }

  setUpAll(() {
    InjectionService.registerFactory<NearVenuesCubit>(
      () => mockNearVenuesCubit,
    );
  });

  setUp(() {
    mockNearVenuesCubit = MockNearVenuesCubit();
  });

  tearDownAll(InjectionService.reset);

  testWidgets(
    'Should display loading when state is NearVenuesLoadingState',
    (WidgetTester tester) async {
      when(() => mockNearVenuesCubit.state).thenReturn(
        NearVenuesLoadingState(),
      );
      when(() => mockNearVenuesCubit.fetchData()).thenAnswer(
        (_) async {},
      );

      await createWidget(tester);

      expect(
        find.byType(NearVenuesListLoading),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should display error when state is NearVenuesErrorState',
    (WidgetTester tester) async {
      when(() => mockNearVenuesCubit.state).thenReturn(
        NearVenuesErrorState(),
      );
      when(() => mockNearVenuesCubit.fetchData()).thenAnswer(
        (_) async {},
      );

      await createWidget(tester);

      expect(
        find.byType(NearVenuesError),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should display loaded list when state is NearVenuesLoadedState',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        when(() => mockNearVenuesCubit.state).thenReturn(
          NearVenuesLoadedState(venuesList: expectedVenueList),
        );
        when(() => mockNearVenuesCubit.fetchData()).thenAnswer(
          (_) async {},
        );

        await createWidget(tester);

        expect(
          find.byType(NearVenuesListLoaded),
          findsOneWidget,
        );
      }, createHttpClient: createMockImageHttpClient);
    },
  );
}
