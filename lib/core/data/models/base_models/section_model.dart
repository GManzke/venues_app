import 'package:venues_app/core/domain/entities/base_entities/section_entity.dart';

class SectionModel extends SectionEntity {
  const SectionModel({
    required super.template,
    required super.items,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      template: SectionTemplates.values.firstWhere(
        (element) => element.name == json['template'],
        orElse: () => SectionTemplates.notDefined,
      ),
      items: json['items'] as List<dynamic>?,
    );
  }
}
