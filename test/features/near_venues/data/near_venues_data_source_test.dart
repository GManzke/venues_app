import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';
import 'package:venues_app/features/near_venues/domain/errors/near_venues_errors.dart';

import '../utils/near_venues_responses.dart';

class MockHttpClient extends Mock implements HttpClientService {}

void main() {
  late HttpClientService httpClient;
  late NearVenuesDataSourceImpl dataSource;

  setUp(() {
    httpClient = MockHttpClient();
    dataSource = NearVenuesDataSourceImpl(httpClient: httpClient);
  });

  group('getNearVenues - ', () {
    test(
        'Should return a list of VenueLargeItemModel '
        'when the request is successful', () async {
      const expectedLocation = (latitude: 1.0, longitude: 2.0);
      const expectedMaxItems = 15;

      when(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: NearVenuesResponses.nearVenuesSuccessJson,
        ),
      );

      final result = await dataSource.getNearVenues(
        maxItems: expectedMaxItems,
        location: expectedLocation,
      );

      expect(result, isA<List>());
    });

    test(
        'Should return a limited list of VenueLargeItemModel '
        'when size exceeds maxItems', () async {
      const expectedLocation = (latitude: 1.0, longitude: 2.0);
      const expectedMaxItems = 3;

      when(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: NearVenuesResponses.nearVenuesSuccessJson,
        ),
      );

      final result = await dataSource.getNearVenues(
        maxItems: expectedMaxItems,
        location: expectedLocation,
      );

      expect(result.length, expectedMaxItems);
    });

    test(
        'Should return an empty list '
        'when the response does not have any venue', () async {
      when(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          data: NearVenuesResponses.nearVenuesEmptyJson,
        ),
      );

      final result = await dataSource.getNearVenues(
        maxItems: 15,
        location: (latitude: 1.0, longitude: 2.0),
      );

      expect(result.isEmpty, isTrue);
    });

    test(
        'Should throw a NearVenuesGenericException '
        'when the request is unsuccessful', () async {
      when(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => const HttpResponse(
          data: '',
          statusCode: 400,
        ),
      );

      final result = dataSource.getNearVenues(
        maxItems: 15,
        location: (latitude: 1.0, longitude: 2.0),
      );

      expect(result, throwsA(isA<NearVenuesGenericException>()));
    });
  });
}
