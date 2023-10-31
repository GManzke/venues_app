import 'package:equatable/equatable.dart';
import 'package:venues_app/core/wrappers/location/location_service.dart';

class VenueInfoEntity extends Equatable {
  final String id;
  final String name;
  final String? shortDescription;
  final Location location;

  const VenueInfoEntity({
    required this.id,
    required this.name,
    required this.location,
    this.shortDescription,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        shortDescription,
      ];
}
