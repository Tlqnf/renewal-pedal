import 'package:pedal/domain/map/entities/ride_entity.dart';

class RideResponse {
  final String id;
  final String userId;
  final String? title;
  final DateTime startedAt;
  final DateTime endedAt;
  final int distanceM;
  final int durationSec;
  final int? caloriesKcal;
  final String visibility;

  const RideResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.startedAt,
    required this.endedAt,
    required this.distanceM,
    required this.durationSec,
    required this.caloriesKcal,
    required this.visibility,
  });

  factory RideResponse.fromJson(Map<String, dynamic> json) => RideResponse(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String?,
    startedAt: DateTime.parse(json['started_at'] as String),
    endedAt: DateTime.parse(json['ended_at'] as String),
    distanceM: json['distance_m'] as int,
    durationSec: json['duration_sec'] as int,
    caloriesKcal: json['calories_kcal'] as int?,
    visibility: json['visibility'] as String,
  );

  RideEntity toEntity() => RideEntity(
    id: id,
    userId: userId,
    title: title,
    startedAt: startedAt,
    endedAt: endedAt,
    distanceM: distanceM,
    durationSec: durationSec,
    caloriesKcal: caloriesKcal,
    visibility: visibility,
  );
}
