import 'package:http/http.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service.dart';

class HttpClientServiceImpl implements HttpClientService {
  final Client client;
  final String baseUrl;
  final Duration timeout;

  HttpClientServiceImpl({
    required this.client,
    required this.baseUrl,
    required this.timeout,
  });

  Uri _buildUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri.parse(baseUrl).replace(
      path: path,
      queryParameters: queryParameters?.map(
            (key, value) => MapEntry(
              key,
              value.toString(),
            ),
          ) ??
          {},
    );
  }

  @override
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? queryParameters}) {
    final uri = _buildUri(path, queryParameters: queryParameters);
    return client.get(uri).timeout(timeout).then(
          (response) => HttpResponse(
            data: response.body,
            statusCode: response.statusCode,
          ),
        );
  }
}
