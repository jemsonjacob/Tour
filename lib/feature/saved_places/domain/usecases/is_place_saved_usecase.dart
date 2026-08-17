import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';

class IsPlaceSavedUseCase implements UseCase<bool, String> {
  final SavedPlacesRepository _savedPlacesRepository;

  IsPlaceSavedUseCase(this._savedPlacesRepository);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    try {
      final isSaved = await _savedPlacesRepository.isPlaceSaved(params);

      return Right(isSaved);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
