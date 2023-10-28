import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/core/http_client/http_client_impl.dart';

class MockClient extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late MockClient mockClient;
  late HttpClientImpl httpClientImpl;

  const baseUrl = 'https://restaurant-api.wolt.com';
  const timeout = 10;

  final successResponse = Response(
    '{"sections": []}',
    200,
    request: Request('GET', Uri.parse(baseUrl)),
  );

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    httpClientImpl = HttpClientImpl(
      client: mockClient,
      baseUrl: baseUrl,
      timeout: timeout,
    );
  });

  test('Should return a success response when using GET with Query Params',
      () async {
    const expectedPath = '/v1/pages/v1/restaurants';
    const expectedQueryParams = {
      'lat': 60.170,
      'lon': 24.930,
    };

    when(() => mockClient.get(any())).thenAnswer(
      (_) async => successResponse,
    );

    final result = await httpClientImpl.get(
      expectedPath,
      queryParameters: expectedQueryParams,
    );

    expect(result.statusCode, 200);
    expect(result.data, '{"sections": []}');

    verify(
      () => mockClient.get(
        Uri.parse(baseUrl).replace(
          path: expectedPath,
          queryParameters: expectedQueryParams.map(
            (key, value) => MapEntry(key, value.toString()),
          ),
        ),
      ),
    ).called(1);
  });
}
