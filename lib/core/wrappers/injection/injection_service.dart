import 'package:get_it/get_it.dart';

class InjectionService {
  static final GetIt _getIt = GetIt.instance;

  static T get<T extends Object>() => _getIt.get<T>();

  static void registerFactory<T extends Object>(T Function() factoryFunc) =>
      _getIt.registerFactory<T>(factoryFunc);

  static void registerLazySingleton<T extends Object>(
          T Function() factoryFunc) =>
      _getIt.registerLazySingleton<T>(factoryFunc);

  static void registerSingleton<T extends Object>(T instance) =>
      _getIt.registerSingleton<T>(instance);

  static void reset() => _getIt.reset();
}
