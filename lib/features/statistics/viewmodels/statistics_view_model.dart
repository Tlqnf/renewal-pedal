import 'package:flutter/foundation.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/use_cases/get_weekly_stats_use_case.dart';

class StatisticsViewModel extends ChangeNotifier {
  final GetWeeklyStatsUseCase _getWeeklyStatsUseCase;

  StatisticsViewModel({required GetWeeklyStatsUseCase getWeeklyStatsUseCase})
    : _getWeeklyStatsUseCase = getWeeklyStatsUseCase;

  double _todayDistanceKm = 0.0;
  String _motivationMessage = '오늘도 와주셨군요!';
  final List<double> _milestoneTargets = [3.0, 6.0, 9.0];
  String? _dailyRewardMessage;
  List<DailyStatEntity> _weeklyStats = [];
  DateTime _selectedWeekStart = _startOfCurrentWeek();
  DateTime _selectedWeekEnd = _endOfCurrentWeek();
  int _weeklyTotalDurationSeconds = 0;
  double _weeklyMaxSpeedKmh = 0.0;
  bool _isLoading = false;
  String? _errorMessage;

  double get todayDistanceKm => _todayDistanceKm;
  String get motivationMessage => _motivationMessage;
  List<double> get milestoneTargets => _milestoneTargets;
  String? get dailyRewardMessage => _dailyRewardMessage;
  List<DailyStatEntity> get weeklyStats => _weeklyStats;
  DateTime get selectedWeekStart => _selectedWeekStart;
  DateTime get selectedWeekEnd => _selectedWeekEnd;
  int get weeklyTotalDurationSeconds => _weeklyTotalDurationSeconds;
  double get weeklyMaxSpeedKmh => _weeklyMaxSpeedKmh;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  static DateTime _startOfCurrentWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  static DateTime _endOfCurrentWeek() {
    final start = _startOfCurrentWeek();
    return start.add(const Duration(days: 6));
  }

  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await _loadWeeklyStats();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadWeeklyStats() async {
    final result = await _getWeeklyStatsUseCase.execute(
      weekStart: _selectedWeekStart,
      weekEnd: _selectedWeekEnd,
    );

    result.fold((failure) => _errorMessage = failure.message, (stats) {
      _weeklyStats = stats;
      _computeDerivedStats(stats);
    });
  }

  void _computeDerivedStats(List<DailyStatEntity> stats) {
    final today = DateTime.now();
    final todayStat = stats.where(
      (s) =>
          s.date.year == today.year &&
          s.date.month == today.month &&
          s.date.day == today.day,
    );

    _todayDistanceKm = todayStat.isNotEmpty ? todayStat.first.distanceKm : 0.0;

    _weeklyTotalDurationSeconds = stats.fold(
      0,
      (sum, s) => sum + s.durationSeconds,
    );

    _weeklyMaxSpeedKmh = stats.isNotEmpty
        ? stats.map((s) => s.maxSpeedKmh).reduce((a, b) => a > b ? a : b)
        : 0.0;

    _updateMotivationAndReward();
  }

  void _updateMotivationAndReward() {
    if (_todayDistanceKm >= 10.0) {
      _motivationMessage = '대단해요! 오늘 정말 열심히 달리셨군요!';
      _dailyRewardMessage = '오늘 치킨 한 마리 만큼 라이딩에 불태웠어요!';
    } else if (_todayDistanceKm >= 5.0) {
      _motivationMessage = '훌륭해요! 오늘도 와주셨군요!';
      _dailyRewardMessage = '오늘 아이스크림 하나 만큼 라이딩에 불태웠어요!';
    } else if (_todayDistanceKm > 0.0) {
      _motivationMessage = '오늘도 와주셨군요!';
      _dailyRewardMessage = null;
    } else {
      _motivationMessage = '오늘도 라이딩 어때요?';
      _dailyRewardMessage = null;
    }
  }

  void onPreviousWeek() {
    _selectedWeekStart = _selectedWeekStart.subtract(const Duration(days: 7));
    _selectedWeekEnd = _selectedWeekEnd.subtract(const Duration(days: 7));
    _loadWeeklyStats().then((_) => notifyListeners());
  }

  void onNextWeek() {
    _selectedWeekStart = _selectedWeekStart.add(const Duration(days: 7));
    _selectedWeekEnd = _selectedWeekEnd.add(const Duration(days: 7));
    _loadWeeklyStats().then((_) => notifyListeners());
  }
}
