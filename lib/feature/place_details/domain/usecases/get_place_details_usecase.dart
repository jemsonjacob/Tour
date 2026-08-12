// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_details_entity.dart';
import 'package:tourexplorer/feature/place_details/domain/repository/place_details_repository.dart';

class GetPlaceDetailsUsecase {
  final PlaceDetailsRepository repository;
  GetPlaceDetailsUsecase(this.repository);

  Future<Either<Failure, PlaceDetailEntity>> call({required String placeId}) {
    return repository.getPlaceDetails(placeId: placeId);
  }
}
