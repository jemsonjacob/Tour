part of 'place_details_bloc.dart';

sealed class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetPlaceDetailsEvent extends PlaceDetailsEvent {
  final String placeId;

  const GetPlaceDetailsEvent({required this.placeId});

  @override
  List<Object?> get props => [placeId];
}
