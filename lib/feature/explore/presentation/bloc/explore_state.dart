import 'package:equatable/equatable.dart';
import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<PlaceEntity> places;

  const ExploreLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExploreLocationRequired extends ExploreState {
  final bool permissionPermanentlyDenied;

  const ExploreLocationRequired({this.permissionPermanentlyDenied = false});

  @override
  List<Object?> get props => [permissionPermanentlyDenied];
}
