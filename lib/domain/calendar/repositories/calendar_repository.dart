import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class CalendarRepository {
  Future<({Failure? failure, CalendarMonthlyStatsEntity? data})>
  getMonthlyStats({required int year, required int month});

  Future<({Failure? failure, List<CalendarWeekSectionEntity>? data})>
  getWeekSections({required int year, required int month});
}
