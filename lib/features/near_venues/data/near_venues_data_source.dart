import 'dart:convert';

import 'package:venues_app/core/data/models/base_models/section_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_large_item_model.dart';
import 'package:venues_app/core/domain/entities/base_entities/section_entity.dart';
import 'package:venues_app/core/wrappers/http_client/http_client.dart';
import 'package:venues_app/features/near_venues/domain/errors/near_venues_errors.dart';

abstract class NearVenuesDataSource {
  Future<List<VenueLargeItemModel>> getNearVenues({
    required double lat,
    required double lon,
  });
}

class NearVenuesDataSourceImpl implements NearVenuesDataSource {
  final HttpClient httpClient;

  NearVenuesDataSourceImpl({required this.httpClient});

  static const path = '/v1/pages/restaurants';

  @override
  Future<List<VenueLargeItemModel>> getNearVenues({
    required double lat,
    required double lon,
  }) async {
    final response = await httpClient.get(path, queryParameters: {
      'lat': lat,
      'lon': lon,
    });

    if (response.isSuccess) {
      final responseFromJson = jsonDecode(response.data as String);

      final sections = (responseFromJson['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList();

      final venueListSection = sections.firstWhere(
        (element) => element.template == SectionTemplates.venueVerticalList,
      );

      if (venueListSection.items?.isEmpty ?? true) {
        throw NearVenuesNotFoundException();
      }

      return venueListSection.items!
          .map((e) => VenueLargeItemModel.fromJson(e))
          .toList();
    } else {
      throw NearVenuesGenericException();
    }
  }
}
