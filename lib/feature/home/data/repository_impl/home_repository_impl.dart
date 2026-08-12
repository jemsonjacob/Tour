// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/exceptions/exceptions.dart';

import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PlaceEntity>>> getPlaces({
    required String query,
    required double latitude,
    required double longitude,
    int radius = 30000,
  }) async {
    try {
      final places = await remoteDataSource.getPlaces(
        query: query,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );

      return Right(places);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (_) {
      return const Left(ServerFailure('Something went wrong'));
    }
  }
}
