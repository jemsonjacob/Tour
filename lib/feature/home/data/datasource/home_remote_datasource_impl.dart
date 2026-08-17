import 'package:dio/dio.dart';
import 'package:tourexplorer/core/exceptions/exceptions.dart';
import '../models/place_model.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PlaceModel>> getPlaces({
    required String query,
    required double latitude,
    required double longitude,
    int radius = 30000,
  }) async {
    try {
      final response = await dio.get(
        '/places/search',
        queryParameters: {
          'll': '$latitude,$longitude',
          'radius': radius,
          'limit': 20,
          'query': query,
        },
      );

      final List results = response.data['results'] ?? [];
      //{fsq_place_id: 4dcccf3cc65bdac71338ec38, latitude: 10.109629150846482,
      // longitude: 76.18783506514907,
      //categories: [{fsq_category_id: 4bf58dd8d48988d1e2941735, name: Beach, short_name: Beach,
      // plural_name: Beaches,
      // icon: {prefix: https://ss3.4sqi.net/img/categories_v2/parks_outdoors/beach_, suffix: .png}}],
      // date_created: 2011-05-13, date_refreshed: 2026-02-23, distance: 8887, extended_location: {},
      // link: /places/4dcccf3cc65bdac71338ec38, location: {address: , locality: Ernākulam,
      //region: Kerala, postcode: , country: IN, formatted_address: Ernākulam, Kerala},
      //name: Kuzhupilli Beach,
      // placemaker_url: https://foursquare.com/placemakers/review-place/4dcccf3cc65bdac71338ec38,
      //related_places: {}, social_media: {twitter: }},

      return results
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message']?.toString() ?? 'Failed to fetch places',
      );
    }
  }
}
