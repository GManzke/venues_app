import 'package:venues_app/core/domain/entities/venue_large_item/venue_info_entity.dart';

class VenueInfoModel extends VenueInfoEntity {
  const VenueInfoModel({
    required super.id,
    required super.name,
    required super.location,
    super.shortDescription,
  });

  factory VenueInfoModel.fromJson(Map<String, dynamic> json) {
    return VenueInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: (
        latitude: (json['location'] as List<dynamic>)[1] as double,
        longitude: (json['location'] as List<dynamic>)[0] as double,
      ),
      shortDescription: json['short_description'] as String?,
    );
  }

  VenueInfoEntity toEntity() => VenueInfoEntity(
        id: id,
        name: name,
        location: location,
        shortDescription: shortDescription,
      );
}
