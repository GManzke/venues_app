import 'package:venues_app/core/domain/entities/base_entities/item_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';

class VenueLargeItemEntity extends ItemEntity {
  final VenueInfoEntity info;
  final VenueImageEntity image;

  const VenueLargeItemEntity({
    required this.info,
    required this.image,
  }) : super(ItemTemplates.venueLarge);

  @override
  List<Object?> get props => [
        info,
        image,
        super.template,
      ];
}
