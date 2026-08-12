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
