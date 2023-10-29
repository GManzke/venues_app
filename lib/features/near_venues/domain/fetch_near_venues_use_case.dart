import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';
import 'package:venues_app/features/near_venues/data/near_venues_repository.dart';

class FetchNearVenuesUseCase {
  final NearVenuesRepository nearVenuesRepository;

  FetchNearVenuesUseCase(this.nearVenuesRepository);

  Future<List<VenueLargeItemEntity>> call() async =>
      nearVenuesRepository.getNearVenues(maxItems: 15);
}
