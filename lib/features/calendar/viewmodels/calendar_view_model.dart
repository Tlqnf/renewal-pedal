import 'package:flutter/foundation.dart';
import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/calendar/use_cases/get_calendar_data_use_case.dart';

class CalendarViewModel extends ChangeNotifier {
  final GetCalendarDataUseCase _getCalendarDataUseCase;

  CalendarViewModel({required GetCalendarDataUseCase getCalendarDataUseCase})
    : _getCalendarDataUseCase = getCalendarDataUseCase;

  DateTime focusedMonth = DateTime.now();
  DateTime? selectedDate;
  CalendarMonthlyStatsEntity? monthlyStats;
  List<CalendarWeekSectionEntity> weekSections = [];
  Set<String> expandedWeekKeys = {};
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getCalendarDataUseCase(
      year: focusedMonth.year,
      month: focusedMonth.month,
    );

    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      monthlyStats = result.stats;
      weekSections = result.sections ?? [];
      if (weekSections.isNotEmpty) {
        expandedWeekKeys = {weekSections.first.key};
      }
    }

    isLoading = false;
    notifyListeners();
  }

  void onPreviousMonth() {
    focusedMonth = DateTime(focusedMonth.year, focusedMonth.month - 1);
    loadData();
  }

  void onNextMonth() {
    focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + 1);
    loadData();
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void onWeekSectionToggle(String weekKey) {
    if (expandedWeekKeys.contains(weekKey)) {
      expandedWeekKeys = {...expandedWeekKeys}..remove(weekKey);
    } else {
      expandedWeekKeys = {...expandedWeekKeys, weekKey};
    }
    notifyListeners();
  }
}
