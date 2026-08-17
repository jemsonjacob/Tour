import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';

class RemovePlaceUseCase implements UseCase<void, String> {
  final SavedPlacesRepository _savedPlacesRepository;

  RemovePlaceUseCase(this._savedPlacesRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    try {
      await _savedPlacesRepository.removePlace(params);

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
