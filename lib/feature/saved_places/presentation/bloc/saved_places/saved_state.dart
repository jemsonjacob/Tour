import 'package:equatable/equatable.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

abstract class SavedPlacesState extends Equatable {
  const SavedPlacesState();

  @override
  List<Object?> get props => [];
}

class SavedPlaceInitial extends SavedPlacesState {
  const SavedPlaceInitial();
}

class SavedPlaceLoading extends SavedPlacesState {
  const SavedPlaceLoading();
}

class SavedPlaceLoaded extends SavedPlacesState {
  final List<PlaceEntity> places;

  const SavedPlaceLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class SavedPlaceError extends SavedPlacesState {
  final String message;

  const SavedPlaceError(this.message);

  @override
  List<Object?> get props => [message];
}
