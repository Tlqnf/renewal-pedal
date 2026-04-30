import 'package:pedal/data/map/sources/ride_remote_source.dart';
import 'package:pedal/data/models/ride/finish_ride_request.dart';
import 'package:pedal/data/models/ride/ride_response.dart';
import 'package:pedal/data/models/ride/ride_track_response.dart';

class RideMockRemoteSource implements RideRemoteSource {
  @override
  Future<RideResponse> finishRide(FinishRideRequest request) async {
    final now = DateTime.now();
    return RideResponse(
      id: 'ride_mock_001',
      userId: 'user_mock_001',
      title: '오늘의 라이딩',
      startedAt: now.subtract(const Duration(hours: 1)),
      endedAt: now,
      distanceM: 12500,
      durationSec: 3600,
      caloriesKcal: 320,
      visibility: 'public',
    );
  }

  @override
  Future<RideTrackResponse> getRideTrack(String rideId) async {
    return const RideTrackResponse(polyline: '');
  }

  @override
  Future<RideResponse> getRide(String rideId) async {
    final now = DateTime.now();
    return RideResponse(
      id: rideId,
      userId: 'user_mock_001',
      title: '라이딩 기록',
      startedAt: now.subtract(const Duration(hours: 1)),
      endedAt: now,
      distanceM: 10000,
      durationSec: 3000,
      caloriesKcal: 280,
      visibility: 'public',
    );
  }

  @override
  Future<void> deleteRide(String rideId) async {}
}
