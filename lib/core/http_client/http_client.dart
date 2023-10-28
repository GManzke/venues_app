import 'package:equatable/equatable.dart';

abstract class HttpClient {
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}

class HttpResponse extends Equatable {
  final Object? data;
  final int statusCode;

  const HttpResponse({
    required this.data,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        data,
        statusCode,
      ];
}
