import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/data/data_sources/favorite_venues_local_data_source.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service_impl.dart';
import 'package:venues_app/core/wrappers/injection/injection_service.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';
import 'package:venues_app/core/wrappers/location/location_service_impl.dart';
import 'package:venues_app/core/wrappers/location/location_service_mock.dart';
import 'package:venues_app/core/wrappers/preferences/preferences_storage.dart';

const isMock = true;

class CoreDI {
  static Future<void> config() async {
    InjectionService.registerLazySingleton<HttpClientService>(
      () => HttpClientServiceImpl(
        baseUrl: 'https://restaurant-api.wolt.com',
        client: http.Client(),
        timeout: const Duration(seconds: 10),
      ),
    );

    if (isMock) {
      InjectionService.registerLazySingleton<LocationService>(
        () => LocationServiceMock(),
      );
    } else {
      InjectionService.registerLazySingleton<LocationService>(
        () => LocationServiceImpl(),
      );
    }

    final sharedPrefs = await SharedPreferences.getInstance();

    InjectionService.registerLazySingleton<PreferencesStorage>(
        () => PreferencesStorageImpl(sharedPreferences: sharedPrefs));

    InjectionService.registerFactory<UserLocationDataSource>(
      () => UserLocationDataSourceImpl(
        InjectionService.get<LocationService>(),
      ),
    );

    InjectionService.registerFactory<FavoriteVenuesLocalDataSource>(
      () => FavoriteVenuesLocalDataSourceImpl(
          storage: InjectionService.get<PreferencesStorage>()),
    );
  }
}
