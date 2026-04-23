import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_ride_log_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/calendar/repositories/calendar_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  @override
  Future<({Failure? failure, CalendarMonthlyStatsEntity? data})>
  getMonthlyStats({required int year, required int month}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: CalendarMonthlyStatsEntity(
        year: year,
        month: month,
        totalDistanceKm: 124.5,
        avgPace: "4'32\"",
        totalDurationMinutes: 340,
        totalCalorieKcal: 2850,
      ),
    );
  }

  @override
  Future<({Failure? failure, List<CalendarWeekSectionEntity>? data})>
  getWeekSections({required int year, required int month}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        CalendarWeekSectionEntity(
          key: '$year-$month-w3',
          weekStart: DateTime(year, month, 12),
          weekEnd: DateTime(year, month, 18),
          rideLogs: [
            CalendarRideLogEntity(
              id: 'log_1',
              date: DateTime(year, month, 14),
              distanceKm: 32.4,
              durationMinutes: 95,
              avgSpeedKmh: 20.5,
              calorieKcal: 680,
            ),
            CalendarRideLogEntity(
              id: 'log_2',
              date: DateTime(year, month, 16),
              distanceKm: 18.7,
              durationMinutes: 55,
              avgSpeedKmh: 20.4,
              calorieKcal: 390,
            ),
          ],
        ),
        CalendarWeekSectionEntity(
          key: '$year-$month-w2',
          weekStart: DateTime(year, month, 5),
          weekEnd: DateTime(year, month, 11),
          rideLogs: [
            CalendarRideLogEntity(
              id: 'log_3',
              date: DateTime(year, month, 7),
              distanceKm: 25.0,
              durationMinutes: 75,
              avgSpeedKmh: 20.0,
              calorieKcal: 520,
            ),
          ],
        ),
      ],
    );
  }
}
