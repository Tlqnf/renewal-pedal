import 'package:flutter/foundation.dart';
import 'package:pedal/domain/ranking/entities/ranking_entity.dart';
import 'package:pedal/domain/ranking/use_cases/get_ranking_use_case.dart';

class RankingViewModel extends ChangeNotifier {
  final GetRankingUseCase _getRankingUseCase;

  RankingViewModel({required GetRankingUseCase getRankingUseCase})
      : _getRankingUseCase = getRankingUseCase;

  int selectedTabIndex = 0;
  List<RankingEntity> rankingList = [];
  bool isLoading = false;
  String? errorMessage;

  static const tabs = ['거리', '연속 주행', '시간', '총 칼로리'];

  RankingTab get _currentTab => RankingTab.values[selectedTabIndex];

  Future<void> loadRanking() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getRankingUseCase(_currentTab);
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      rankingList = result.data ?? [];
    }

    isLoading = false;
    notifyListeners();
  }

  void onTabChanged(int index) {
    selectedTabIndex = index;
    loadRanking();
  }
}
