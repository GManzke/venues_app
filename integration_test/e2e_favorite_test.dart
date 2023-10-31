import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/application_di.dart';
import 'package:venues_app/core/wrappers/injection/injection_service.dart';
import 'package:venues_app/main.dart';

void main() {
  tearDownAll(InjectionService.reset);

  testWidgets('Should successfully favorite the first venue',
      (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await ApplicationDI.init();

    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final favoriteIcon = find.byIcon(Icons.favorite);
    expect(favoriteIcon, findsOneWidget);
    await tester.tap(favoriteIcon);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
