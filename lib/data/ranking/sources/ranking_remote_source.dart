import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/ranking/ranking_response.dart';

class RankingRemoteSource {
  final DioClient _client;

  RankingRemoteSource(this._client);

  Future<RankingResponse> getRanking(String rankingType) async {
    final response = await _client.get('/users/ranking/$rankingType');
    return RankingResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
