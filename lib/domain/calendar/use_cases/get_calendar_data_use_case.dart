import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/calendar/repositories/calendar_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetCalendarDataUseCase {
  final CalendarRepository _repository;

  GetCalendarDataUseCase(this._repository);

  Future<
    ({
      Failure? failure,
      CalendarMonthlyStatsEntity? stats,
      List<CalendarWeekSectionEntity>? sections,
    })
  >
  call({required int year, required int month}) async {
    final statsResult = await _repository.getMonthlyStats(
      year: year,
      month: month,
    );
    if (statsResult.failure != null) {
      return (failure: statsResult.failure, stats: null, sections: null);
    }
    final sectionsResult = await _repository.getWeekSections(
      year: year,
      month: month,
    );
    if (sectionsResult.failure != null) {
      return (
        failure: sectionsResult.failure,
        stats: statsResult.data,
        sections: null,
      );
    }
    return (
      failure: null,
      stats: statsResult.data,
      sections: sectionsResult.data,
    );
  }
}
