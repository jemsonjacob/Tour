import 'package:tourexplorer/feature/home/data/models/place_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PlaceModel>> getPlaces({
    required String query,
    required double latitude,
    required double longitude,
    int radius = 30000,
  });
}
