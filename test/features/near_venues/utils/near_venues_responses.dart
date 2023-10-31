import 'dart:io';

import 'package:venues_app/core/data/models/venue_large_item/venue_image_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_info_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_large_item_model.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';

class NearVenuesResponses {
  static const _baseDirectory = 'test/features/near_venues/utils/fixtures';

  static String _getJson(String fileName) =>
      File('$_baseDirectory/$fileName').readAsStringSync();

  static String get nearVenuesSuccessJson =>
      _getJson('near_venues_success.json');

  static String get nearVenuesEmptyJson => _getJson('near_venues_empty.json');

  static List<VenueLargeItemModel> get listOfVenueLargeItemAsModels =>
      List.generate(
        5,
        (index) => VenueLargeItemModel(
          info: VenueInfoModel(
            id: 'Id $index',
            name: 'name $index',
            shortDescription: 'Short description $index',
            location: (latitude: 1.0, longitude: 2.0),
          ),
          image: VenueImageModel(
            url: 'url $index',
          ),
        ),
      );

  static List<VenueLargeItemEntity> get listOfVenueLargeItemAsEntities =>
      List.generate(
        5,
        (index) => VenueLargeItemEntity(
          info: VenueInfoEntity(
            id: 'Id $index',
            name: 'name $index',
            shortDescription: 'Short description $index',
            location: (latitude: 1.0, longitude: 2.0),
          ),
          image: VenueImageEntity(
            url: 'url $index',
          ),
        ),
      );

  static List<VenueLargeItemEntity>
      get listOfVenueLargeItemAsEntitiesWithFavorite => List.generate(
            5,
            (index) => VenueLargeItemEntity(
              isFavorite: index == 0,
              info: VenueInfoEntity(
                id: 'Id $index',
                name: 'name $index',
                shortDescription: 'Short description $index',
                location: (latitude: 1.0, longitude: 2.0),
              ),
              image: VenueImageEntity(
                url: 'url $index',
              ),
            ),
          );
}
