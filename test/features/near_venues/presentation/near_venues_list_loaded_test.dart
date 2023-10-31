import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loaded.dart';
import 'package:venues_app/features/near_venues/presentation/widgets/venue_item_tile.dart';

import '../utils/mock_image_http.dart';

void main() {
  final expectedVenueList = List.generate(5, (index) {
    return VenueLargeItemEntity(
      info: VenueInfoEntity(
        id: '$index',
        name: 'Venue $index',
        shortDescription: 'Venue $index description',
        location: (latitude: 1.0, longitude: 2.0),
      ),
      isFavorite: false,
      image: const VenueImageEntity(url: 'www.example.com'),
    );
  });

  Future<void> createWidget(
    WidgetTester tester, {
    required List<VenueLargeItemEntity> venuesList,
    Function(int index)? onFavoritePressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NearVenuesListLoaded(
            venuesList: venuesList,
            onFavoritePressed: onFavoritePressed ?? (_) {},
          ),
        ),
      ),
    );
  }

  testWidgets(
    'Should render a list of venues',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        await createWidget(
          tester,
          venuesList: expectedVenueList,
        );
        expect(find.byType(ListView), findsOneWidget);
        expect(
          find.byType(VenueItemTile),
          findsNWidgets(expectedVenueList.length),
        );
      }, createHttpClient: createMockImageHttpClient);
    },
  );

  testWidgets(
    'Should call onFavoritePressed when favorite icon is pressed '
    'with the correct index',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        var index = -1;

        await createWidget(
          tester,
          venuesList: expectedVenueList,
          onFavoritePressed: (int i) => index = i,
        );

        await tester.tap(find.byIcon(Icons.favorite_border).first);
        expect(index, 0);

        await tester.tap(find.byIcon(Icons.favorite_border).last);
        expect(index, 4);
      }, createHttpClient: createMockImageHttpClient);
    },
  );
}
