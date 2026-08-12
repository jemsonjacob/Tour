import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/feature/place_details/domain/entities/place_details_entity.dart';
import 'package:tourexplorer/feature/place_details/domain/usecases/get_place_details_usecase.dart';

part 'place_details_event.dart';
part 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final GetPlaceDetailsUsecase getPlaceDetailsUsecase;

  PlaceDetailsBloc({required this.getPlaceDetailsUsecase})
    : super(PlaceDetailsInitial()) {
    on<GetPlaceDetailsEvent>(_onGetPlaceDetails);
  }

  Future<void> _onGetPlaceDetails(
    GetPlaceDetailsEvent event,
    Emitter<PlaceDetailsState> emit,
  ) async {
    emit(PlaceDetailsLoading());

    final response = await getPlaceDetailsUsecase(placeId: event.placeId);

    response.fold(
      (failure) {
        emit(PlaceDetailsError(failure.message));
      },
      (place) {
        emit(PlaceDetailsLoaded(place));
      },
    );
  }
}
