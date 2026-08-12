part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PlaceEntity> popularPlaces;
  final List<PlaceEntity> recommendedPlaces;

  const HomeLoaded(this.popularPlaces, this.recommendedPlaces);

  @override
  List<Object?> get props => [popularPlaces, recommendedPlaces];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

class HomeLocationRequired extends HomeState {
  final bool permissionPermanentlyDenied;

  const HomeLocationRequired({this.permissionPermanentlyDenied = false});

  @override
  List<Object?> get props => [permissionPermanentlyDenied];
}
