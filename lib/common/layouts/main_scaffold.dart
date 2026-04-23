import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/features/statistics/pages/statistics_page.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/features/home/pages/home_page.dart';
import 'package:pedal/features/activity/pages/activity_page.dart';
import 'package:pedal/features/activity/viewmodels/activity_view_model.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_challenges_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_recommended_crews_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_stats_use_case.dart';
import 'package:pedal/mock/sources/activity_mock_repository.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 홈
          HomePage(
            userName: '페달러',
            pointBalance: 0,
            motivationMessage: '오늘도 힘차게 달려볼까요?',
            todayDistanceKm: 0,
            todayCalorieKcal: 0,
            aiMissionTitle: '15일동안 자전거 라이딩 하기',
            aiMissionDescription: '매일 꾸준히 라이딩하며 건강한 습관을 만들어보세요.',
            currentNavIndex: _currentIndex,
            isLoading: false,
            onNavTap: _onNavTap,
            onStoreTap: () {},
            onCalendarTap: () => context.push(AppRoutes.calendar),
            onRankingTap: () => context.push(AppRoutes.ranking),
            onAiMissionTap: () => context.push(AppRoutes.aiMission),
            onAiMissionCtaTap: () => context.push(AppRoutes.aiMission),
            onNotificationTap: () {},
            onPointChargeTap: () {},
            onEventTap: () => context.push(AppRoutes.event),
            onBannerTap: () => context.push(AppRoutes.event),
          ),
          // 피드 (미구현)
          const _PlaceholderTab(label: '피드', icon: Icons.article_rounded),
          // 지도 — 중앙 FAB이므로 빈 화면
          const SizedBox.shrink(),
          // 활동
          ChangeNotifierProvider(
            create: (_) => ActivityViewModel(
              getChallengesUseCase: GetActivityChallengesUseCase(
                ActivityMockRepository(),
              ),
              getCrewsUseCase: GetRecommendedCrewsUseCase(
                ActivityMockRepository(),
              ),
              getStatsUseCase: GetActivityStatsUseCase(
                ActivityMockRepository(),
              ),
            ),
            child: const ActivityPageConnected(),
          ),
          // 통계
          StatisticsPage(
            todayDistanceKm: 0,
            motivationMessage: "화이팅 하거라",
            milestoneTargets: [10, 10, 10, 10, 10],
            weeklyStats: [],
            selectedWeekStart: DateTime.utc(2026, 4, 12),
            selectedWeekEnd: DateTime.utc(2026, 4, 18),
            weeklyTotalDurationSeconds: 123,
            weeklyMaxSpeedKmh: 30.2,
            challengeBadges: [],
            isLoading: false,
            onPreviousWeek: () {}, // TODO: 추가 필요
            onNextWeek: () {}, // TODO: 추가 필요
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlaceholderTab({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.gray300),
            const SizedBox(height: 12),
            Text(
              '$label 준비 중',
              style: AppTextStyles.titMd.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
