import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';

import 'package:tourexplorer/feature/place_details/domain/entities/place_details_entity.dart';

abstract class PlaceDetailsRepository {
  Future<Either<Failure, PlaceDetailEntity>> getPlaceDetails({
    required String placeId,
  });
}
