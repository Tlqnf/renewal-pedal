import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  int pointBalance = 26000;
  bool isLoading = false;

  // HeroBanner
  String weatherLabel = '날씨 좋은 날';
  String bannerTitle = '자전거 함께\n타실래요?';
  String bannerSubtitle = '페달을 구르면 기분이 조크든요\n오늘도 신나게 라이딩!';

  // RideStreakCard
  int streakGoalWeeks = 14;
  int streakCurrentWeeks = 13;
  int streakCurrentDays = 6;
  int streakPointReward = 120;

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    // TODO: 실제 UseCase 연결
    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
    notifyListeners();
  }
}
