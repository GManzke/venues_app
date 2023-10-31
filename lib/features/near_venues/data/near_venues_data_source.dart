import 'dart:convert';

import 'package:http/http.dart';
import 'package:venues_app/core/data/models/base_models/section_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_large_item_model.dart';
import 'package:venues_app/core/domain/entities/base_entities/section_entity.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';
import 'package:venues_app/core/wrappers/log_service/log_service.dart';
import 'package:venues_app/features/near_venues/domain/errors/near_venues_errors.dart';

abstract class NearVenuesDataSource {
  Future<List<VenueLargeItemModel>> getNearVenues({
    required int maxItems,
    required Location location,
  });
}

class NearVenuesDataSourceImpl implements NearVenuesDataSource {
  final HttpClientService httpClient;

  NearVenuesDataSourceImpl({required this.httpClient});

  static const path = '/v1/pages/restaurants';

  @override
  Future<List<VenueLargeItemModel>> getNearVenues({
    required int maxItems,
    required Location location,
  }) async {
    try {
      final response = await httpClient.get(path, queryParameters: {
        'lat': location.latitude,
        'lon': location.longitude,
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
          return [];
        }

        return venueListSection.items!
            .take(maxItems)
            .map((e) => VenueLargeItemModel.fromJson(e))
            .toList();
      } else {
        LogService.breadcrumb(
            '[Near Venues Cubit]: ${response.statusCode} - ${response.data.toString()}');

        throw NearVenuesGenericException();
      }
    } on ClientException {
      throw NearVenuesNetworkException();
    } catch (e) {
      throw NearVenuesGenericException();
    }
  }
}
