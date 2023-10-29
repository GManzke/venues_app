import 'package:equatable/equatable.dart';

class VenueInfoEntity extends Equatable {
  final String id;
  final String name;
  final String? shortDescription;

  const VenueInfoEntity({
    required this.id,
    required this.name,
    this.shortDescription,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        shortDescription,
      ];
}
