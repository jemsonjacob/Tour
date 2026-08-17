import 'package:equatable/equatable.dart';

abstract class SavedPlacesEvent extends Equatable {
  const SavedPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedPlacesEvent extends SavedPlacesEvent {
  const LoadSavedPlacesEvent();
}
