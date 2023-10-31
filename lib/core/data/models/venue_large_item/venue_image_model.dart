import 'package:venues_app/core/domain/entities/venue_large_item/venue_image_entity.dart';

class VenueImageModel extends VenueImageEntity {
  const VenueImageModel({
    required super.url,
  });

  factory VenueImageModel.fromJson(Map<String, dynamic> json) {
    return VenueImageModel(
      url: json['url'],
    );
  }

  VenueImageEntity toEntity() => VenueImageEntity(
        url: url,
      );
}
