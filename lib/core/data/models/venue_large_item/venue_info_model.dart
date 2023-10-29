import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';

class VenueInfoModel extends VenueInfoEntity {
  const VenueInfoModel({
    required super.id,
    required super.name,
    super.shortDescription,
  });

  factory VenueInfoModel.fromJson(Map<String, dynamic> json) {
    return VenueInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      shortDescription: json['short_description'] as String?,
    );
  }
}
