import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/is_place_saved_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/remove_place_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/save_place_usecase.dart';

class PlaceSavedStatusCubit extends Cubit<bool> {
  final SavePlaceUseCase savePlaceUseCase;
  final RemovePlaceUseCase removePlaceUseCase;
  final IsPlaceSavedUseCase isPlaceSavedUseCase;

  PlaceSavedStatusCubit({
    required this.savePlaceUseCase,
    required this.removePlaceUseCase,
    required this.isPlaceSavedUseCase,
  }) : super(false);

  Future<void> savePlace(PlaceEntity place) async {
    final result = await savePlaceUseCase(place);

    result.fold(
      (failure) {
        // Handle error if needed
      },
      (_) {
        emit(true);
      },
    );
  }

  Future<void> removeSavedPlace(String id) async {
    final result = await removePlaceUseCase(id);

    result.fold(
      (failure) {
        // Handle error if needed
      },
      (_) {
        emit(false);
      },
    );
  }

  Future<void> checkPlaceSaved(String id) async {
    final result = await isPlaceSavedUseCase(id);

    result.fold(
      (failure) {
        // Handle error if needed
      },
      (isSaved) {
        emit(isSaved);
      },
    );
  }
}
