import 'package:pedal/domain/map/entities/route_entity.dart';

class RouteResponse {
  final String id;
  final String? rideId;
  final String routeName;
  final double distance;
  final String duration;
  final int calories;

  const RouteResponse({
    required this.id,
    this.rideId,
    required this.routeName,
    required this.distance,
    required this.duration,
    required this.calories,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
    id: (json['id'] ?? '').toString(),
    rideId: json['ride_id']?.toString(),
    routeName: (json['name'] ?? json['route_name'] ?? '') as String,
    distance:
        ((json['distance_km'] ?? json['distance']) as num?)?.toDouble() ?? 0.0,
    duration: _formatDuration((json['duration_sec'] as num?)?.toInt()),
    calories:
        ((json['calories_kcal'] ?? json['calories']) as num?)?.toInt() ?? 0,
  );

  static String _formatDuration(int? seconds) {
    if (seconds == null) return '0m';
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  RouteEntity toEntity() => RouteEntity(
    id: id,
    rideId: rideId,
    routeName: routeName,
    distance: distance,
    duration: duration,
    calories: calories,
  );
}
