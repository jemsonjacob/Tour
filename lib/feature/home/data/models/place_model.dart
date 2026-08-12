import '../../domain/entities/place_entity.dart';
import 'category_model.dart';
import 'location_model.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.distance,
    required super.category,
    required super.location,
    super.phone,
    super.website,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'] as List? ?? [];

    return PlaceModel(
      id: json['fsq_place_id'] ?? '',
      name: json['name'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      distance: json['distance'] ?? 0,
      category: categories.isNotEmpty
          ? CategoryModel.fromJson(categories.first)
          : const CategoryModel(id: '', name: '', shortName: '', iconUrl: ''),
      location: LocationModel.fromJson(json['location'] ?? {}),
      phone: json['tel'],
      website: json['website'],
    );
  }
}
