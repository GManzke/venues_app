import 'package:equatable/equatable.dart';

class VenueImageEntity extends Equatable {
  final String url;

  const VenueImageEntity({
    required this.url,
  });

  @override
  List<Object?> get props => [
        url,
      ];
}
