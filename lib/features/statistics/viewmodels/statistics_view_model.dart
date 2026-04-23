import 'package:flutter/foundation.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';
import 'package:pedal/domain/statistics/use_cases/get_weekly_stats_use_case.dart';
import 'package:pedal/domain/statistics/use_cases/get_challenge_badges_use_case.dart';

class StatisticsViewModel extends ChangeNotifier {
  final GetWeeklyStatsUseCase _getWeeklyStatsUseCase;
  final GetChallengeBadgesUseCase _getChallengeBadgesUseCase;

  StatisticsViewModel({
    required GetWeeklyStatsUseCase getWeeklyStatsUseCase,
    required GetChallengeBadgesUseCase getChallengeBadgesUseCase,
  }) : _getWeeklyStatsUseCase = getWeeklyStatsUseCase,
       _getChallengeBadgesUseCase = getChallengeBadgesUseCase;

  // 상태
  double todayDistanceKm = 0.0;
  String motivationMessage = '오늘도 와주셨군요!';
  List<double> milestoneTargets = [3.0, 6.0, 9.0];
  String? dailyRewardMessage;
  List<DailyStatEntity> weeklyStats = [];
  DateTime selectedWeekStart = _startOfCurrentWeek();
  DateTime selectedWeekEnd = _endOfCurrentWeek();
  int weeklyTotalDurationSeconds = 0;
  double weeklyMaxSpeedKmh = 0.0;
  List<ChallengeBadgeEntity> challengeBadges = [];
  bool isLoading = false;
  String? errorMessage;

  static DateTime _startOfCurrentWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  static DateTime _endOfCurrentWeek() {
    final start = _startOfCurrentWeek();
    return start.add(const Duration(days: 6));
  }

  Future<void> loadData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await Future.wait([_loadWeeklyStats(), _loadChallengeBadges()]);

    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadWeeklyStats() async {
    final result = await _getWeeklyStatsUseCase.execute(
      weekStart: selectedWeekStart,
      weekEnd: selectedWeekEnd,
    );

    result.fold((failure) => errorMessage = failure.message, (stats) {
      weeklyStats = stats;
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

    todayDistanceKm = todayStat.isNotEmpty ? todayStat.first.distanceKm : 0.0;

    weeklyTotalDurationSeconds = stats.fold(
      0,
      (sum, s) => sum + s.durationSeconds,
    );

    weeklyMaxSpeedKmh = stats.isNotEmpty
        ? stats.map((s) => s.maxSpeedKmh).reduce((a, b) => a > b ? a : b)
        : 0.0;

    _updateMotivationAndReward();
  }

  void _updateMotivationAndReward() {
    if (todayDistanceKm >= 10.0) {
      motivationMessage = '대단해요! 오늘 정말 열심히 달리셨군요!';
      dailyRewardMessage = '오늘 치킨 한 마리 만큼 라이딩에 불태웠어요!';
    } else if (todayDistanceKm >= 5.0) {
      motivationMessage = '훌륭해요! 오늘도 와주셨군요!';
      dailyRewardMessage = '오늘 아이스크림 하나 만큼 라이딩에 불태웠어요!';
    } else if (todayDistanceKm > 0.0) {
      motivationMessage = '오늘도 와주셨군요!';
      dailyRewardMessage = null;
    } else {
      motivationMessage = '오늘도 라이딩 어때요?';
      dailyRewardMessage = null;
    }
  }

  Future<void> _loadChallengeBadges() async {
    final result = await _getChallengeBadgesUseCase.execute();

    result.fold(
      (failure) => errorMessage ??= failure.message,
      (badges) => challengeBadges = badges,
    );
  }

  void onPreviousWeek() {
    selectedWeekStart = selectedWeekStart.subtract(const Duration(days: 7));
    selectedWeekEnd = selectedWeekEnd.subtract(const Duration(days: 7));
    _loadWeeklyStats().then((_) => notifyListeners());
  }

  void onNextWeek() {
    selectedWeekStart = selectedWeekStart.add(const Duration(days: 7));
    selectedWeekEnd = selectedWeekEnd.add(const Duration(days: 7));
    _loadWeeklyStats().then((_) => notifyListeners());
  }
}
