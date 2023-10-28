import 'package:equatable/equatable.dart';

enum SectionTemplates {
  venueVerticalList('venue-vertical-list'),
  notDefined('not-defined');

  final String name;

  const SectionTemplates(this.name);
}

class SectionEntity extends Equatable {
  final SectionTemplates template;
  final List<dynamic>? items;

  const SectionEntity({
    required this.template,
    this.items,
  });

  @override
  List<Object?> get props => [
        template,
        items,
      ];
}
