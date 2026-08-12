import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.shortName,
    required super.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final icon = json['icon'] ?? {};

    return CategoryModel(
      id: json['fsq_category_id'] ?? '',
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      iconUrl: '${icon['prefix'] ?? ''}64${icon['suffix'] ?? ''}',
    );
  }
}
