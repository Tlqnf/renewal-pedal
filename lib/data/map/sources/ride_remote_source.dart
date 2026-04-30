import 'package:flutter/foundation.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/ride/finish_ride_request.dart';
import 'package:pedal/data/models/ride/ride_response.dart';
import 'package:pedal/data/models/ride/ride_track_response.dart';

class RideRemoteSource {
  final DioClient _client;

  RideRemoteSource(this._client);

  Future<RideResponse> finishRide(FinishRideRequest request) async {
    final requestBody = request.toJson();
    debugPrint('[RideRemoteSource] POST /rides/finish 요청 데이터: $requestBody');

    final response = await _client.post('/rides/finish', data: requestBody);

    debugPrint(
      '[RideRemoteSource] POST /rides/finish 응답 statusCode: ${response.statusCode}',
    );
    debugPrint(
      '[RideRemoteSource] POST /rides/finish 응답 데이터: ${response.data}',
    );

    return RideResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<RideTrackResponse> getRideTrack(String rideId) async {
    final response = await _client.get('/rides/$rideId/track');
    return RideTrackResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<RideResponse> getRide(String rideId) async {
    final response = await _client.get('/rides/$rideId');
    return RideResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteRide(String rideId) async {
    await _client.delete('/rides/$rideId');
  }
}
