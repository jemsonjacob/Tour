import 'package:hive_flutter/hive_flutter.dart';
import 'package:tourexplorer/feature/saved_places/data/models/saved_place_model.dart';

abstract class SavedPlacesLocalDatasource {
  Future<void> savePlace(SavedPlaceModel place);

  Future<void> removePlace(String id);

  List<SavedPlaceModel> getSavedPlaces();

  bool isPlaceSaved(String id);
}

// implementation
class SavedLocalDatasourceImpl implements SavedPlacesLocalDatasource {
  final Box<SavedPlaceModel> box;
  SavedLocalDatasourceImpl(this.box);

  @override
  Future<void> removePlace(String id) async {
    await box.delete(id);
  }

  @override
  List<SavedPlaceModel> getSavedPlaces() {
    return box.values.toList();
  }

  @override
  bool isPlaceSaved(String id) {
    return box.containsKey(id);
  }

  @override
  Future<void> savePlace(SavedPlaceModel place) async {
    //print("Before save: ${box.length}");

    await box.put(place.id, place); //key,value

    //print("After save: ${box.length}");
  }
}
