import 'package:equatable/equatable.dart';

class PlacePhotoEntity extends Equatable {
  final String prefix;
  final String suffix;
  final int width;
  final int height;

  const PlacePhotoEntity({
    required this.prefix,
    required this.suffix,
    required this.width,
    required this.height,
  });

  String get imageUrl => '$prefix${width}x$height$suffix';

  @override
  List<Object?> get props => [prefix, suffix, width, height];
}
