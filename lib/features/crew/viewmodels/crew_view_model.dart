import 'package:flutter/foundation.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/use_cases/get_recommended_crews_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_stats_use_case.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class ActivityViewModel extends ChangeNotifier {
  final GetRecommendedCrewsUseCase _getCrewsUseCase;
  final GetActivityStatsUseCase _getStatsUseCase;

  ActivityViewModel({
    required GetRecommendedCrewsUseCase getCrewsUseCase,
    required GetActivityStatsUseCase getStatsUseCase,
  }) : _getCrewsUseCase = getCrewsUseCase,
       _getStatsUseCase = getStatsUseCase;

  List<CrewEntity> _crews = [];
  bool _isLoadingCrews = false;

  ActivityStatsEntity _stats = const ActivityStatsEntity(
    officialCount: 0,
    unofficialCount: 0,
    totalParticipants: 0,
  );

  // ignore: prefer_final_fields
  String _userName = 'OOO';
  String? _errorMessage;

  List<CrewEntity> get crews => _crews;
  bool get isLoadingCrews => _isLoadingCrews;

  ActivityStatsEntity get stats => _stats;
  String get userName => _userName;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    await Future.wait([fetchCrews(), fetchStats()]);
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
    result.fold((failure) {}, (entity) => _stats = entity);
    notifyListeners();
  }

  void onCrewTap(String id) {}
  void onCreateCrew() {}
  void onSearch() {}
  void onNotification() {}
  void onSettings() {}
}
