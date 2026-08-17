import 'package:hive_flutter/hive_flutter.dart';

import '../../../home/domain/entities/category_entity.dart';
import '../../../home/domain/entities/location_entity.dart';
import '../../../home/domain/entities/place_entity.dart';

part 'saved_place_model.g.dart';

@HiveType(typeId: 2)
class SavedPlaceModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final int distance;

  @HiveField(5)
  final String categoryId;

  @HiveField(6)
  final String categoryName;

  @HiveField(7)
  final String categoryShortName;

  @HiveField(8)
  final String categoryIconUrl;

  @HiveField(9)
  final String address;

  @HiveField(10)
  final String locality;

  @HiveField(11)
  final String region;

  @HiveField(12)
  final String country;

  @HiveField(13)
  final String formattedAddress;

  @HiveField(14)
  final String? phone;

  @HiveField(15)
  final String? website;

  SavedPlaceModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.categoryId,
    required this.categoryName,
    required this.categoryShortName,
    required this.categoryIconUrl,
    required this.address,
    required this.locality,
    required this.region,
    required this.country,
    required this.formattedAddress,
    this.phone,
    this.website,
  });

  factory SavedPlaceModel.fromEntity(PlaceEntity place) {
    return SavedPlaceModel(
      id: place.id,
      name: place.name,
      latitude: place.latitude,
      longitude: place.longitude,
      distance: place.distance,

      categoryId: place.category.id,
      categoryName: place.category.name,
      categoryShortName: place.category.shortName,
      categoryIconUrl: place.category.iconUrl,

      address: place.location.address,
      locality: place.location.locality,
      region: place.location.region,
      country: place.location.country,
      formattedAddress: place.location.formattedAddress,

      phone: place.phone,
      website: place.website,
    );
  }

  PlaceEntity toEntity() {
    return PlaceEntity(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      distance: distance,

      category: CategoryEntity(
        id: categoryId,
        name: categoryName,
        shortName: categoryShortName,
        iconUrl: categoryIconUrl,
      ),

      location: LocationEntity(
        address: address,
        locality: locality,
        region: region,
        country: country,
        formattedAddress: formattedAddress,
      ),

      phone: phone,
      website: website,
    );
  }
}
