import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:tourexplorer/feature/saved_places/domain/usecases/get_saved_places_usecase.dart';

import 'saved_event.dart';
import 'saved_state.dart';

class SavedPlaceBloc extends Bloc<SavedPlacesEvent, SavedPlacesState> {
  final GetSavedPlacesUseCase getSavedPlacesUseCase;

  SavedPlaceBloc({required this.getSavedPlacesUseCase})
    : super(const SavedPlaceInitial()) {
    on<LoadSavedPlacesEvent>(_onLoadSavedPlaces);
  }

  Future<void> _onLoadSavedPlaces(
    LoadSavedPlacesEvent event,
    Emitter<SavedPlacesState> emit,
  ) async {
    emit(const SavedPlaceLoading());

    final result = await getSavedPlacesUseCase(NoParams());

    result.fold(
      (failure) => emit(SavedPlaceError(failure.message)),
      (places) => emit(SavedPlaceLoaded(places)),
    );
  }
}
