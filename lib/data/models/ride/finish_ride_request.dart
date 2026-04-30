import 'package:pedal/data/models/ride/ride_point_in.dart';

class FinishRideRequest {
  final String? title;
  final DateTime startedAt;
  final DateTime endedAt;
  final int distanceM;
  final int durationSec;
  final int? caloriesKcal;
  final String visibility;
  final List<RidePointIn> points;
  final bool saveAsRoute;
  final String? routeName;

  const FinishRideRequest({
    required this.title,
    required this.startedAt,
    required this.endedAt,
    required this.distanceM,
    required this.durationSec,
    required this.caloriesKcal,
    this.visibility = 'public',
    required this.points,
    this.saveAsRoute = false,
    required this.routeName,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'started_at': startedAt.toUtc().toIso8601String(),
    'ended_at': endedAt.toUtc().toIso8601String(),
    'distance_m': distanceM,
    'duration_sec': durationSec,
    'calories_kcal': caloriesKcal,
    'visibility': visibility,
    'points': points.map((p) => p.toJson()).toList(),
    'save_as_route': saveAsRoute,
    'route_name': routeName,
  };
}
