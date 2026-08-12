import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/exceptions/location_exceptions.dart';
import 'package:tourexplorer/core/services/location_service.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_event.dart';
import 'package:tourexplorer/feature/explore/presentation/bloc/explore_state.dart';
import 'package:tourexplorer/feature/home/domain/usecases/home_usecase.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetPlacesUseCase getPlacesUseCase;
  final LocationService locationService;

  ExploreBloc({required this.getPlacesUseCase, required this.locationService})
    : super(ExploreInitial()) {
    on<SearchPlacesEvent>(_onSearchPlaces);
  }

  Future<void> _onSearchPlaces(
    SearchPlacesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(ExploreLoading());

    try {
      final position = await locationService.getCurrentLocation();

      final response = await getPlacesUseCase(
        query: event.query,
        latitude: position.latitude,
        longitude: position.longitude,
        radius: 30000,
      );

      response.fold(
        (failure) {
          emit(ExploreError(failure.message));
        },
        (places) {
          emit(ExploreLoaded(places));
        },
      );
    } on LocationServiceDisabledException {
      emit(const ExploreLocationRequired());
    } on LocationPermissionDeniedException {
      emit(const ExploreLocationRequired());
    } on LocationPermissionPermanentlyDeniedException {
      emit(const ExploreLocationRequired(permissionPermanentlyDenied: true));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }
}
