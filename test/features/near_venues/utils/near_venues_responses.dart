import 'dart:io';

import 'package:venues_app/core/data/models/venue_large_item/venue_image_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_info_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_large_item_model.dart';

class NearVenuesResponses {
  static const _baseDirectory = 'test/features/near_venues/utils/fixtures';

  static String _getJson(String fileName) =>
      File('$_baseDirectory/$fileName').readAsStringSync();

  static String get nearVenuesSuccessJson =>
      _getJson('near_venues_success.json');

  static String get nearVenuesEmptyJson => _getJson('near_venues_empty.json');

  static List<VenueLargeItemModel> get nearVenuesModelList => [
        const VenueLargeItemModel(
          info: VenueInfoModel(
            id: 'id',
            name: 'name',
            shortDescription: 'Short description',
          ),
          image: VenueImageModel(
            url: 'url',
          ),
        ),
      ];
}
