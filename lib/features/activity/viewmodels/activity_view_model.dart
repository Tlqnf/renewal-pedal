import 'package:flutter/foundation.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_challenges_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_recommended_crews_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_stats_use_case.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class ActivityViewModel extends ChangeNotifier {
  final GetActivityChallengesUseCase _getChallengesUseCase;
  final GetRecommendedCrewsUseCase _getCrewsUseCase;
  final GetActivityStatsUseCase _getStatsUseCase;

  ActivityViewModel({
    required GetActivityChallengesUseCase getChallengesUseCase,
    required GetRecommendedCrewsUseCase getCrewsUseCase,
    required GetActivityStatsUseCase getStatsUseCase,
  })  : _getChallengesUseCase = getChallengesUseCase,
        _getCrewsUseCase = getCrewsUseCase,
        _getStatsUseCase = getStatsUseCase;

  // 상태
  List<ChallengeEntity> _challenges = [];
  bool _isLoadingChallenges = false;

  List<CrewEntity> _crews = [];
  bool _isLoadingCrews = false;

  ActivityStatsEntity _stats = const ActivityStatsEntity(
    officialCount: 0,
    unofficialCount: 0,
    totalParticipants: 0,
  );

  // userName은 추후 인증에서 주입받을 수 있도록 var로 유지
  // ignore: prefer_final_fields
  String _userName = 'OOO';
  String? _errorMessage;

  // Getters
  List<ChallengeEntity> get challenges => _challenges;
  bool get isLoadingChallenges => _isLoadingChallenges;

  List<CrewEntity> get crews => _crews;
  bool get isLoadingCrews => _isLoadingCrews;

  ActivityStatsEntity get stats => _stats;
  String get userName => _userName;
  String? get errorMessage => _errorMessage;

  // 초기 로드
  Future<void> init() async {
    await Future.wait([
      fetchChallenges(),
      fetchCrews(),
      fetchStats(),
    ]);
  }

  Future<void> fetchChallenges() async {
    _isLoadingChallenges = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getChallengesUseCase.execute();
    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _challenges = list,
    );

    _isLoadingChallenges = false;
    notifyListeners();
  }

  Future<void> fetchCrews() async {
    _isLoadingCrews = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getCrewsUseCase.execute();
    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _crews = list,
    );

    _isLoadingCrews = false;
    notifyListeners();
  }

  Future<void> fetchStats() async {
    final result = await _getStatsUseCase.execute();
    result.fold(
      (failure) {},
      (entity) => _stats = entity,
    );
    notifyListeners();
  }

  // 액션 (라우팅은 Page에서 처리)
  void onChallengeTap(String id) {}
  void onCrewTap(String id) {}
  void onCreateChallenge() {}
  void onCreateCrew() {}
  void onSearch() {}
  void onNotification() {}
  void onSettings() {}
}
