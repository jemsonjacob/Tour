import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String address;
  final String locality;
  final String region;
  final String country;
  final String formattedAddress;

  const LocationEntity({
    required this.address,
    required this.locality,
    required this.region,
    required this.country,
    required this.formattedAddress,
  });

  @override
  List<Object?> get props => [
    address,
    locality,
    region,
    country,
    formattedAddress,
  ];
}
