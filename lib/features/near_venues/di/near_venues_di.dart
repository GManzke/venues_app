import 'package:venues_app/core/data/data_sources/user_location_data_source.dart';
import 'package:venues_app/core/data/data_sources/favorite_venues_local_data_source.dart';
import 'package:venues_app/core/wrappers/http_client/http_client_service.dart';
import 'package:venues_app/core/wrappers/injection/injection_service.dart';
import 'package:venues_app/features/near_venues/data/near_venues_data_source.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';
import 'package:venues_app/features/near_venues/domain/fetch_near_venues_use_case.dart';
import 'package:venues_app/features/near_venues/domain/remove_venue_from_favorites_use_case.dart';
import 'package:venues_app/features/near_venues/domain/save_venue_as_favorite_use_case.dart';
import 'package:venues_app/features/near_venues/presentation/controller/near_venues_cubit.dart';

class NearVenuesDI {
  static void config() {
    _configDataSources();
    _configRepositories();
    _configUseCases();
    _configControllers();
  }

  static void _configDataSources() {
    InjectionService.registerLazySingleton<NearVenuesDataSource>(
      () => NearVenuesDataSourceImpl(
        httpClient: InjectionService.get<HttpClientService>(),
      ),
    );
  }

  static void _configRepositories() {
    InjectionService.registerLazySingleton<NearVenuesRepository>(
      () => NearVenuesRepositoryImpl(
        nearVenuesSource: InjectionService.get<NearVenuesDataSource>(),
        locationDataSource: InjectionService.get<UserLocationDataSource>(),
        favoritesDataSource:
            InjectionService.get<FavoriteVenuesLocalDataSource>(),
      ),
    );
  }

  static void _configUseCases() {
    InjectionService.registerLazySingleton<FetchNearVenuesUseCase>(
      () => FetchNearVenuesUseCase(
        InjectionService.get<NearVenuesRepository>(),
      ),
    );
    InjectionService.registerLazySingleton<RemoveVenueFromFavoritesUseCase>(
      () => RemoveVenueFromFavoritesUseCase(
        InjectionService.get<NearVenuesRepository>(),
      ),
    );
    InjectionService.registerLazySingleton<SaveVenueAsFavoriteUseCase>(
      () => SaveVenueAsFavoriteUseCase(
        InjectionService.get<NearVenuesRepository>(),
      ),
    );
  }

  static void _configControllers() {
    InjectionService.registerFactory<NearVenuesCubit>(
      () => NearVenuesCubit(
        fetchNearVenuesUseCase: InjectionService.get<FetchNearVenuesUseCase>(),
        saveFavoriteVenueUseCase:
            InjectionService.get<SaveVenueAsFavoriteUseCase>(),
        removeFavoriteVenueUseCase:
            InjectionService.get<RemoveVenueFromFavoritesUseCase>(),
      ),
    );
  }
}
