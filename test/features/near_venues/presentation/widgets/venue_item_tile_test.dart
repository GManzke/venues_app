import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/core/design_system/ds_icon_button.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/presentation/widgets/venue_item_tile.dart';

import '../../utils/mock_image_http.dart';

void main() {
  const expectedVenue = VenueLargeItemEntity(
    info: VenueInfoEntity(
      id: '1',
      name: 'Venue name',
      shortDescription: 'Venue short description',
      location: (latitude: 1.0, longitude: 2.0),
    ),
    image: VenueImageEntity(
      url: 'https://www.example.com',
    ),
    isFavorite: false,
    distance: 1000,
  );

  Future<void> createWidget(
    WidgetTester tester, {
    required VenueLargeItemEntity venue,
    VoidCallback? onFavoritePressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VenueItemTile(
            venue: venue,
            onFavoritePressed: onFavoritePressed ?? () {},
          ),
        ),
      ),
    );
  }

  testWidgets(
    'Should render the venue name, distance, short description and favorite icon',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        await createWidget(
          tester,
          venue: expectedVenue,
        );

        expect(find.text(expectedVenue.info.name), findsOneWidget);
        expect(find.text('1.0 km\n${expectedVenue.shortDescription!}'),
            findsOneWidget);
        expect(find.byType(DSIconButton), findsOneWidget);
      }, createHttpClient: createMockImageHttpClient);
    },
  );

  testWidgets(
    'Should call onFavoritePressed when favorite icon is pressed',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        var isFavoritePressed = false;
        await createWidget(
          tester,
          venue: expectedVenue,
          onFavoritePressed: () {
            isFavoritePressed = true;
          },
        );

        await tester.tap(find.byIcon(Icons.favorite_border));
        await tester.pump();

        expect(isFavoritePressed, isTrue);
      }, createHttpClient: createMockImageHttpClient);
    },
  );
}
