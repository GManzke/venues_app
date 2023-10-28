import 'package:equatable/equatable.dart';

enum ItemTemplates {
  venueLarge('venue-large'),
  notDefined('not-defined');

  final String type;

  const ItemTemplates(this.type);
}

class ItemEntity extends Equatable {
  final ItemTemplates template;

  const ItemEntity(this.template);

  @override
  List<Object?> get props => [
        template,
      ];
}
