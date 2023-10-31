import 'package:venues_app/core/domain/entities/base_entities/item_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';

class VenueLargeItemEntity extends ItemEntity {
  final VenueInfoEntity info;
  final VenueImageEntity image;
  final bool isFavorite;

  /// Distance in meters from the user's location.
  final int? distance;

  const VenueLargeItemEntity({
    required this.info,
    required this.image,
    this.isFavorite = false,
    this.distance,
  }) : super(ItemTemplates.venueLarge);

  @override
  List<Object?> get props => [
        info,
        image,
        isFavorite,
        super.template,
      ];

  String get id => info.id;

  String get name => info.name;

  String get imageUrl => image.url;

  String? get shortDescription => info.shortDescription;

  VenueLargeItemEntity copyWith({
    required bool isFavorite,
    int? distance,
  }) {
    return VenueLargeItemEntity(
      info: info,
      image: image,
      isFavorite: isFavorite,
      distance: distance ?? this.distance,
    );
  }
}
