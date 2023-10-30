import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/features/near_venues/presentation/widgets/venue_rectangle_avatar.dart';

import '../../utils/mock_image_http.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester, {
    required String url,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VenueRectangleAvatar(
            imageUrl: url,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'Should render image widget',
    (WidgetTester tester) async {
      HttpOverrides.runZoned<Future<void>>(() async {
        const url = 'www.example.com';

        await createWidget(
          tester,
          url: url,
        );

        expect(find.byType(Image), findsOneWidget);
      }, createHttpClient: createMockImageHttpClient);
    },
  );
}
