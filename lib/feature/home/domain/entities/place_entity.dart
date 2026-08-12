import 'package:equatable/equatable.dart';

import 'category_entity.dart';
import 'location_entity.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String name;

  final double latitude;
  final double longitude;

  final int distance;

  final CategoryEntity category;
  final LocationEntity location;

  final String? phone;
  final String? website;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.category,
    required this.location,
    this.phone,
    this.website,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    latitude,
    longitude,
    distance,
    category,
    location,
    phone,
    website,
  ];
}
