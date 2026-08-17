import 'package:tourexplorer/feature/home/domain/entities/place_entity.dart';
import 'package:tourexplorer/feature/saved_places/data/datasource/saved_local_datasource.dart';
import 'package:tourexplorer/feature/saved_places/data/models/saved_place_model.dart';
import 'package:tourexplorer/feature/saved_places/domain/repositories/saved_repository.dart';

//PlaceEntity-> SavedPlaceModel->SavedLocalDatasource  ->Hive
class SavedPlacesRepositoryImpl implements SavedPlacesRepository {
  final SavedPlacesLocalDatasource localDatasource;

  SavedPlacesRepositoryImpl({required this.localDatasource});

  @override
  Future<List<PlaceEntity>> getSavedPlaces() async {
    final places = localDatasource.getSavedPlaces();

    return places.map((place) => place.toEntity()).toList();
  }

  @override
  Future<bool> isPlaceSaved(String id) async {
    return localDatasource.isPlaceSaved(id);
  }

  @override
  Future<void> removePlace(String id) async {
    await localDatasource.removePlace(id);
  }

  @override
  Future<void> savePlace(PlaceEntity place) async {
    //placeEntity
    final savedPlace = SavedPlaceModel.fromEntity(place);

    await localDatasource.savePlace(savedPlace);
  }
}
