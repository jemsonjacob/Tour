import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourexplorer/core/exceptions/location_exceptions.dart';
import 'package:tourexplorer/core/services/location_service.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/home/domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPlacesUseCase getPlacesUseCase;
  final LocationService locationService;

  HomeBloc({required this.getPlacesUseCase, required this.locationService})
    : super(HomeInitial()) {
    on<LoadHomePlacesEvent>(_onLoadHomePlaces);
  }

  Future<void> _onLoadHomePlaces(
    LoadHomePlacesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      // Get user's current location
      final position = await locationService.getCurrentLocation();

      // Fetch Beach and Attraction at the same time
      final responses = await Future.wait([
        getPlacesUseCase(
          query: 'Beach',
          latitude: position.latitude,
          longitude: position.longitude,
          radius: 30000,
        ),
        getPlacesUseCase(
          query: 'Attraction',
          latitude: position.latitude,
          longitude: position.longitude,
          radius: 30000,
        ),
      ]);

      final beachResponse = responses[0];
      final attractionResponse = responses[1];

      // Check if either request failed
      if (beachResponse.isLeft() || attractionResponse.isLeft()) {
        final failure =
            beachResponse.fold((failure) => failure, (_) => null) ??
            attractionResponse.fold((failure) => failure, (_) => null);

        emit(HomeError(failure!.message));

        return;
      }

      // Extract results
      final beaches = beachResponse.getOrElse(() => []);

      final attractions = attractionResponse.getOrElse(() => []);

      // Send both lists to UI
      emit(HomeLoaded(beaches, attractions));
    }
    // Location service disabled
    on LocationServiceDisabledException {
      emit(const HomeLocationRequired());
    }
    // Permission denied
    on LocationPermissionDeniedException {
      emit(const HomeLocationRequired());
    }
    // Permission permanently denied
    on LocationPermissionPermanentlyDeniedException {
      emit(const HomeLocationRequired(permissionPermanentlyDenied: true));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
