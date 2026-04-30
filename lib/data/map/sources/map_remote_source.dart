import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/map/route_response.dart';

class MapRemoteSource {
  final DioClient _client;

  MapRemoteSource(this._client);

  Future<List<RouteResponse>> getSavedRoutes({String? search}) async {
    final params = search != null ? {"search": search} : null;
    final response = await _client.get('/map/saved', queryParameters: params);
    final data = response.data;
    final list = (data is Map ? data['routes'] : data) as List<dynamic>;
    return list
        .map((e) => RouteResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<RouteResponse>> aiRecommendRoute(
    Map<String, dynamic> params,
  ) async {
    final response = await _client.post('/map/ai-recommend', data: params);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => RouteResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
