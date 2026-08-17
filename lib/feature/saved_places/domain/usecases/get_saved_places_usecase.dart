import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';

//get saved places
class GetSavedPlacesUseCase implements UseCase<List<PlaceEntity>, void> {
  final SavedPlacesRepository _savedPlacesRepository;
  GetSavedPlacesUseCase(this._savedPlacesRepository);

  @override
  Future<Either<Failure, List<PlaceEntity>>> call(void params) async {
    try {
      final places = await _savedPlacesRepository.getSavedPlaces();

      return Right(places);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
