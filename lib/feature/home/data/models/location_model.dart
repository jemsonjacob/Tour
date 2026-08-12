import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.address,
    required super.locality,
    required super.region,
    required super.country,
    required super.formattedAddress,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'] ?? '',
      locality: json['locality'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
    );
  }
}
