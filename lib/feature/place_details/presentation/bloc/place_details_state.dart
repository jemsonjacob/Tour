part of 'place_details_bloc.dart';

sealed class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object?> get props => [];
}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsLoaded extends PlaceDetailsState {
  final PlaceDetailEntity place;

  const PlaceDetailsLoaded(this.place);

  @override
  List<Object?> get props => [place];
}

class PlaceDetailsError extends PlaceDetailsState {
  final String message;

  const PlaceDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
