import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';

class FetchFavoriteVenuesIDUseCase {
  final NearVenuesRepository repository;

  FetchFavoriteVenuesIDUseCase(this.repository);

  List<String> call() => repository.getFavoriteVenues();
}
