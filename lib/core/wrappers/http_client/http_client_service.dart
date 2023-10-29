import 'package:equatable/equatable.dart';

abstract class HttpClientService {
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

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  @override
  List<Object?> get props => [
        data,
        statusCode,
      ];
}
