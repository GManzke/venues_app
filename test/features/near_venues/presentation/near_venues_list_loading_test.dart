import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/core/design_system/ds_loading.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_loading.dart';

void main() {
  Future<void> createWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NearVenuesListLoading(),
        ),
      ),
    );
  }

  testWidgets(
    'Should render loading shimmer effect',
    (WidgetTester tester) async {
      await createWidget(tester);

      expect(find.byType(DSLoading), findsOneWidget);
      expect(find.byType(ListTile), findsAtLeastNWidgets(5));
    },
  );
}
