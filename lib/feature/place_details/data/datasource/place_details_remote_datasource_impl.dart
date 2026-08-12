import 'package:dio/dio.dart';
import 'package:tourexplorer/feature/place_details/data/datasource/place_details_remote_datasource.dart';
import 'package:tourexplorer/feature/place_details/data/models/place_details_model.dart';
import 'package:tourexplorer/feature/place_details/data/models/place_photo_model.dart';

class PlaceDetailsRemoteDatasourceImpl implements PlaceDetailsRemoteDataSource {
  final Dio dio;

  PlaceDetailsRemoteDatasourceImpl({required this.dio});

  @override
  Future<PlaceDetailModel> getPlaceDetails({required String placeId}) async {
    final response = await dio.get('/places/$placeId');

    // returns a single
    return PlaceDetailModel.fromJson(response.data);
  }

  @override
  Future<List<PlacePhotoModel>> getPlacePhotos({
    required String placeId,
  }) async {
    //   print('PHOTO REQUEST: /places/$placeId/photos');

    final response = await dio.get('/places/$placeId/photos');

    // print('PHOTO RESPONSE: ${response.statusCode}');
    // print('PHOTO DATA: ${response.data}');

    final List results = response.data;

    return results.map((e) => PlacePhotoModel.fromJson(e)).toList();
  }
}
