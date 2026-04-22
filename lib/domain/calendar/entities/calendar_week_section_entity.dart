import 'package:pedal/domain/calendar/entities/calendar_ride_log_entity.dart';

class CalendarWeekSectionEntity {
  final String key;
  final DateTime weekStart;
  final DateTime weekEnd;
  final List<CalendarRideLogEntity> rideLogs;

  const CalendarWeekSectionEntity({
    required this.key,
    required this.weekStart,
    required this.weekEnd,
    required this.rideLogs,
  });
}
