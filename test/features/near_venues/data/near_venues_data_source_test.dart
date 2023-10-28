import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/data/http_client/http_client.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';
import 'package:venues_app/features/near_venues/domain/errors/near_venues_errors.dart';

import '../utils/near_venues_responses.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late NearVenuesDataSourceImpl dataSource;

  setUp(() {
    httpClient = MockHttpClient();
    dataSource = NearVenuesDataSourceImpl(httpClient: httpClient);
  });

  group('getNearVenues - ', () {
    test('Should return a list of VenueModel when the request is successful',
        () async {
      const expectedLatitude = 1.0;
      const expectedLongitude = 2.0;

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
        latitude: expectedLatitude,
        longitude: expectedLongitude,
      );

      expect(result, isA<List>());
    });

    test(
        'Should throw a NearVenuesGenericException when the request is unsuccessful',
        () async {
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
        latitude: 1.0,
        longitude: 2.0,
      );

      expect(result, throwsA(isA<NearVenuesGenericException>()));
    });

    test(
        'Should throw a NearVenuesNotFoundException '
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

      final result = dataSource.getNearVenues(
        latitude: 1.0,
        longitude: 2.0,
      );

      expect(result, throwsA(isA<NearVenuesNotFoundException>()));
    });
  });
}