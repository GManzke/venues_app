import 'dart:io';

class NearVenuesResponses {
  static const _baseDirectory = 'test/features/near_venues/utils/fixtures';

  static String _getJson(String fileName) =>
      File('$_baseDirectory/$fileName').readAsStringSync();

  static String get nearVenuesSuccessJson =>
      _getJson('near_venues_success.json');

  static String get nearVenuesEmptyJson =>
      _getJson('near_venues_empty.json');
}
