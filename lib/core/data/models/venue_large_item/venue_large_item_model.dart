import 'package:venues_app/core/data/models/venue_large_item/venue_image_model.dart';
import 'package:venues_app/core/data/models/venue_large_item/venue_info_model.dart';
import 'package:venues_app/core/domain/entities/venue_large_item/venue_large_item_entity.dart';

class VenueLargeItemModel extends VenueLargeItemEntity {
  const VenueLargeItemModel({
    required super.info,
    required super.image,
  });

  factory VenueLargeItemModel.fromJson(Map<String, dynamic> json) {
    return VenueLargeItemModel(
      info: VenueInfoModel.fromJson(json['venue']),
      image: VenueImageModel.fromJson(json['image']),
    );
  }

  VenueLargeItemEntity toEntity() => VenueLargeItemEntity(
        info: (info as VenueInfoModel).toEntity(),
        image: (image as VenueImageModel).toEntity(),
      );
}
