import 'package:tourexplorer/feature/place_details/data/models/place_photo_model.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_details_entity.dart';

import '../../../home/domain/entities/category_entity.dart';
import '../../../home/domain/entities/location_entity.dart';

class PlaceDetailModel extends PlaceDetailEntity {
  const PlaceDetailModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.category,
    required super.location,
    required super.photos,
    super.phone,
    super.website,
  });

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'] as List? ?? [];

    final categoryJson = categories.isNotEmpty
        ? categories.first as Map<String, dynamic>
        : {};

    final locationJson = json['location'] as Map<String, dynamic>? ?? {};

    final iconJson = categoryJson['icon'] as Map<String, dynamic>? ?? {};

    return PlaceDetailModel(
      id: json['fsq_place_id'] ?? '',
      name: json['name'] ?? 'Unknown Place',

      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),

      category: CategoryEntity(
        id: categoryJson['fsq_category_id'] ?? '',
        name: categoryJson['name'] ?? '',
        shortName: categoryJson['short_name'] ?? '',
        iconUrl: iconJson['suffix'] ?? '',
      ),

      location: LocationEntity(
        address: locationJson['address'] ?? '',
        locality: locationJson['locality'] ?? '',
        region: locationJson['region'] ?? '',
        country: locationJson['country'] ?? '',
        formattedAddress: locationJson['formatted_address'] ?? '',
      ),

      phone: json['tel']?.toString(),
      website: json['website']?.toString(),

      // detail api doesn't contain photos.
      photos: const [],
    );
  }

  //for including photos
  PlaceDetailModel copyWith({List<PlacePhotoModel>? photos}) {
    return PlaceDetailModel(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      category: category,
      location: location,
      phone: phone,
      website: website,
      photos: photos ?? this.photos,
    );
  }
}
