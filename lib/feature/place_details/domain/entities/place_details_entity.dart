import 'package:equatable/equatable.dart';
import 'package:tourexplorer/feature/home/domain/entities/category_entity.dart';
import 'package:tourexplorer/feature/home/domain/entities/location_entity.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_photos_entity.dart';

class PlaceDetailEntity extends Equatable {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final CategoryEntity category;
  final LocationEntity location;
  final String? phone;
  final String? website;
  final String? description;
  //photos
  final List<PlacePhotoEntity> photos;

  const PlaceDetailEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.location,
    this.phone,
    this.website,
    this.description,
    required this.photos,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    latitude,
    longitude,
    category,
    location,
    phone,
    website,
    description,
    photos,
  ];
}
