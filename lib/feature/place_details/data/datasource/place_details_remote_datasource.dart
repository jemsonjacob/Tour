import 'package:tourexplorer/feature/place_details/data/models/place_details_model.dart';
import 'package:tourexplorer/feature/place_details/data/models/place_photo_model.dart';

abstract class PlaceDetailsRemoteDataSource {
  //for place details
  Future<PlaceDetailModel> getPlaceDetails({required String placeId});

  //for place photos
  Future<List<PlacePhotoModel>> getPlacePhotos({required String placeId});
}
