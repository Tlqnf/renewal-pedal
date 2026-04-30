import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/calendar/sources/calendar_remote_source.dart';
import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_ride_log_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/calendar/repositories/calendar_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteSource? _remoteSource;

  /// useMock=true 일 때: 인수 없이 생성 (mock 데이터 반환)
  /// useMock=false 일 때: remoteSource 전달
  CalendarRepositoryImpl([this._remoteSource]);

  // ── pace 변환: km/h → "분'초\"" ────────────────────────────────
  // 예) 20 km/h → 60분/20km = 3분/km → "3'00\""
  String _paceFromKmh(double kmh) {
    if (kmh <= 0) return "0'00\"";
    final secondsPerKm = (3600 / kmh).round();
    final minutes = secondsPerKm ~/ 60;
    final seconds = secondsPerKm % 60;
    return "$minutes'${seconds.toString().padLeft(2, '0')}\"";
  }

  @override
  Future<({Failure? failure, CalendarMonthlyStatsEntity? data})>
  getMonthlyStats({required int year, required int month}) async {
    final source = _remoteSource;
    if (source == null) {
      // mock
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

    try {
      final response = await source.getCalendar(year: year, month: month);
      final s = response.monthlySummary;
      return (
        failure: null,
        data: CalendarMonthlyStatsEntity(
          year: response.year,
          month: response.month,
          totalDistanceKm: s.distanceKm,
          avgPace: _paceFromKmh(s.avgPaceKmh),
          totalDurationMinutes: s.durationSec ~/ 60,
          totalCalorieKcal: s.caloriesKcal,
        ),
      );
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, List<CalendarWeekSectionEntity>? data})>
  getWeekSections({required int year, required int month}) async {
    final source = _remoteSource;
    if (source == null) {
      // mock
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

    try {
      final response = await source.getCalendar(year: year, month: month);
      final sections = response.weeks.map((week) {
        final rideLogs = week.rides.map((ride) {
          return CalendarRideLogEntity(
            id: '${year}_${month}_${ride.day}',
            date: DateTime.parse(ride.date),
            distanceKm: ride.distanceKm,
            durationMinutes: ride.durationSec ~/ 60,
            avgSpeedKmh: ride.avgPaceKmh,
            calorieKcal: ride.caloriesKcal,
          );
        }).toList();

        return CalendarWeekSectionEntity(
          key: week.label,
          weekStart: DateTime.parse(week.startDate),
          weekEnd: DateTime.parse(week.endDate),
          rideLogs: rideLogs,
        );
      }).toList();

      return (failure: null, data: sections);
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }
}
