import 'package:venues_app/core/domain/entities/base_entities/item_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';

class VenueLargeItemEntity extends ItemEntity {
  final VenueInfoEntity info;
  final VenueImageEntity image;
  final bool isFavorite;

  const VenueLargeItemEntity({
    required this.info,
    required this.image,
    this.isFavorite = false,
  }) : super(ItemTemplates.venueLarge);

  @override
  List<Object?> get props => [
        info,
        image,
        isFavorite,
        super.template,
      ];

  VenueLargeItemEntity copyWith({required bool isFavorite}) {
    return VenueLargeItemEntity(
      info: info,
      image: image,
      isFavorite: isFavorite,
    );
  }
}
