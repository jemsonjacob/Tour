import 'package:tourexplorer/feature/place_details/domain/entities/place_photos_entity.dart';

class PlacePhotoModel extends PlacePhotoEntity {
  const PlacePhotoModel({
    required super.prefix,
    required super.suffix,
    required super.width,
    required super.height,
  });

  factory PlacePhotoModel.fromJson(Map<String, dynamic> json) {
    return PlacePhotoModel(
      prefix: json['prefix'] ?? '',
      suffix: json['suffix'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}
