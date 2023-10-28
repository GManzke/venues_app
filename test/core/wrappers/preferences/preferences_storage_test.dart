import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venues_app/core/wrappers/preferences/preferences_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late PreferencesStorageImpl prefsStorage;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    prefsStorage = PreferencesStorageImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  test(
    'Should return true when setStringList is called',
    () async {
      const expectedStringList = ['value_1', 'value_2'];
      const expectedKey = 'key';

      when(
        () => sharedPreferences.setStringList(
          expectedKey,
          expectedStringList,
        ),
      ).thenAnswer((_) async => true);

      final result = await prefsStorage.setStringList(
        expectedKey,
        expectedStringList,
      );

      expect(result, true);
      verify(
        () => sharedPreferences.setStringList(
          expectedKey,
          expectedStringList,
        ),
      );
    },
  );

  test(
    'Should return a list of string when getStringList is called',
    () async {
      const expectedKey = 'key';
      const expectedStringList = ['value_10', 'value_20'];

      when(
        () => sharedPreferences.getStringList(
          expectedKey,
        ),
      ).thenReturn(
        expectedStringList,
      );

      final result = prefsStorage.getStringList('key');

      expect(result, expectedStringList);
      verify(
        () => sharedPreferences.getStringList(expectedKey),
      );
    },
  );
}
