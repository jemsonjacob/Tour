import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PlaceEntity>>> getPlaces({
    required String query,
    required double latitude,
    required double longitude,
    int radius = 30000,
  });
}
