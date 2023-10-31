import 'package:flutter/foundation.dart';

/// Mock wrapper that aims to simulate a real log service.
/// In a real app, this would be a wrapper around a real log service.
class LogService {
  static void breadcrumb(String message,
      [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('=================BREADCRUMB-LOG=================');
      print('$message \n$error \n$stackTrace');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('=================ERROR-LOG=================');
      print('$message \n$error \n$stackTrace');
    }
  }
}
