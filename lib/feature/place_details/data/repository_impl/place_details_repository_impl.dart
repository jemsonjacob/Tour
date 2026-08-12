import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/exceptions/exceptions.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/place_details/data/datasource/place_details_remote_datasource.dart';
import 'package:tourexplorer/feature/place_details/data/models/place_photo_model.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_details_entity.dart';
import 'package:tourexplorer/feature/place_details/domain/repository/place_details_repository.dart';

class PlaceDetailsRepositoryImpl implements PlaceDetailsRepository {
  final PlaceDetailsRemoteDataSource remoteDataSource;

  PlaceDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PlaceDetailEntity>> getPlaceDetails({
    required String placeId,
  }) async {
    try {
      final place = await remoteDataSource.getPlaceDetails(placeId: placeId);

      List<PlacePhotoModel> photos = [];

      try {
        photos = await remoteDataSource.getPlacePhotos(placeId: placeId);
      } catch (e) {
        // print('Photo request failed: $e');
      }

      final placeWithPhotos = place.copyWith(photos: photos);

      return Right(placeWithPhotos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      // print('PLACE DETAILS ERROR: $e');
      return const Left(ServerFailure('Something went wrong'));
    }
  }
}
