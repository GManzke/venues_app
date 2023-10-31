import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:venues_app/features/near_venues/presentation/near_venues_list_error.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester, {
    VoidCallback? onRetryPressed,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NearVenuesError(
            onRetryPressed: onRetryPressed ?? () {},
          ),
        ),
      ),
    );
  }

  testWidgets(
    'Should render the animation, error message and retry button',
    (WidgetTester tester) async {
      await createWidget(
        tester,
      );

      expect(
        find.byType(Lottie),
        findsOneWidget,
      );
      expect(
        find.text('No Internet Connection'),
        findsOneWidget,
      );
      expect(
        find.text('Check your connection and try again'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(ElevatedButton, 'Try Again'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Should call onRetryPressed when retry button is pressed',
    (WidgetTester tester) async {
      var isPressed = false;

      await createWidget(
        tester,
        onRetryPressed: () {
          isPressed = true;
        },
      );

      await tester.tap(
        find.byType(ElevatedButton),
      );

      await tester.pumpAndSettle();

      expect(isPressed, true);
    },
  );
}
