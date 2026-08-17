import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';

class SavePlaceUseCase implements UseCase<void, PlaceEntity> {
  final SavedPlacesRepository _savedPlacesRepository;

  SavePlaceUseCase(this._savedPlacesRepository);

  @override
  Future<Either<Failure, void>> call(PlaceEntity params) async {
    try {
      await _savedPlacesRepository.savePlace(params);

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
