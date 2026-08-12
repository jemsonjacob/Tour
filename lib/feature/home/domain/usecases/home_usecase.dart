import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/home/domain/repositories/home_repository.dart';

class GetPlacesUseCase {
  final HomeRepository repository;

  GetPlacesUseCase(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call({
    required String query,
    required double latitude,
    required double longitude,
    int radius = 30000,
  }) {
    return repository.getPlaces(
      query: query,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );
  }
}

// class PlacesParams {
//   final String query;
//   final double latitude;
//   final double longitude;

//   const PlacesParams({
//     required this.query,
//     required this.latitude,
//     required this.longitude,
//   });
// }
