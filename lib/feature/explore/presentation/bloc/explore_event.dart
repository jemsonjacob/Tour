import 'package:equatable/equatable.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

class SearchPlacesEvent extends ExploreEvent {
  final String query;

  const SearchPlacesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
