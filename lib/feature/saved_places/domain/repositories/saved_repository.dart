import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';

abstract class SavedPlacesRepository {
  Future<void> savePlace(PlaceEntity place);

  Future<void> removePlace(String id);

  Future<List<PlaceEntity>> getSavedPlaces();

  Future<bool> isPlaceSaved(String id);
}
