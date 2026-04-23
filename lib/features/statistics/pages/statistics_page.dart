import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';
import 'package:pedal/features/statistics/viewmodels/statistics_view_model.dart';
import 'package:pedal/features/statistics/widgets/statistics_motivation_banner.dart';
import 'package:pedal/features/statistics/widgets/distance_milestone_bar.dart';
import 'package:pedal/features/statistics/widgets/daily_reward_message_card.dart';
import 'package:pedal/features/statistics/widgets/weekly_bar_chart.dart';
import 'package:pedal/features/statistics/widgets/weekly_time_circle_indicator.dart';
import 'package:pedal/features/statistics/widgets/weekly_max_speed_display.dart';
import 'package:pedal/features/statistics/widgets/challenge_badge_grid.dart';

class StatisticsPage extends StatelessWidget {
  final double todayDistanceKm;
  final String motivationMessage;
  final List<double> milestoneTargets;
  final String? dailyRewardMessage;
  final List<DailyStatEntity> weeklyStats;
  final DateTime selectedWeekStart;
  final DateTime selectedWeekEnd;
  final int weeklyTotalDurationSeconds;
  final double weeklyMaxSpeedKmh;
  final List<ChallengeBadgeEntity> challengeBadges;
  final bool isLoading;
  final String? errorMessage;

  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const StatisticsPage({
    super.key,
    required this.todayDistanceKm,
    required this.motivationMessage,
    required this.milestoneTargets,
    this.dailyRewardMessage,
    required this.weeklyStats,
    required this.selectedWeekStart,
    required this.selectedWeekEnd,
    required this.weeklyTotalDurationSeconds,
    required this.weeklyMaxSpeedKmh,
    required this.challengeBadges,
    required this.isLoading,
    this.errorMessage,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
              child: Text(
                errorMessage!,
                style: const TextStyle(color: AppColors.error),
              ),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: [
        // 동기부여 배너
        SliverToBoxAdapter(
          child: StatisticsMotivationBanner(
            todayDistanceKm: todayDistanceKm,
            motivationMessage: motivationMessage,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        // 마일스톤 진행 바
        SliverToBoxAdapter(
          child: DistanceMilestoneBar(
            todayDistanceKm: todayDistanceKm,
            milestoneTargets: milestoneTargets,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        // 오늘 칭찬 메시지 카드
        if (dailyRewardMessage != null)
          SliverToBoxAdapter(
            child: DailyRewardMessageCard(message: dailyRewardMessage!),
          ),
        if (dailyRewardMessage != null)
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        // 주간 바 차트
        SliverToBoxAdapter(
          child: WeeklyBarChart(
            weeklyStats: weeklyStats,
            selectedWeekStart: selectedWeekStart,
            selectedWeekEnd: selectedWeekEnd,
            onPreviousWeek: onPreviousWeek,
            onNextWeek: onNextWeek,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        // 이번 주 시간 + 최고 속력 (2열)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: WeeklyTimeCircleIndicator(
                    totalDurationSeconds: weeklyTotalDurationSeconds,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: WeeklyMaxSpeedDisplay(maxSpeedKmh: weeklyMaxSpeedKmh),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        // 챌린지 뱃지 그리드
        SliverToBoxAdapter(child: ChallengeBadgeGrid(badges: challengeBadges)),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }
}

class StatisticsPageConnected extends StatefulWidget {
  final int currentNavIndex;
  final ValueChanged<int> onNavTap;

  const StatisticsPageConnected({
    super.key,
    required this.currentNavIndex,
    required this.onNavTap,
  });

  @override
  State<StatisticsPageConnected> createState() =>
      _StatisticsPageConnectedState();
}

class _StatisticsPageConnectedState extends State<StatisticsPageConnected> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsViewModel>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticsViewModel>(
      builder: (context, vm, _) {
        return StatisticsPage(
          todayDistanceKm: vm.todayDistanceKm,
          motivationMessage: vm.motivationMessage,
          milestoneTargets: vm.milestoneTargets,
          dailyRewardMessage: vm.dailyRewardMessage,
          weeklyStats: vm.weeklyStats,
          selectedWeekStart: vm.selectedWeekStart,
          selectedWeekEnd: vm.selectedWeekEnd,
          weeklyTotalDurationSeconds: vm.weeklyTotalDurationSeconds,
          weeklyMaxSpeedKmh: vm.weeklyMaxSpeedKmh,
          challengeBadges: vm.challengeBadges,
          isLoading: vm.isLoading,
          errorMessage: vm.errorMessage,
          onPreviousWeek: vm.onPreviousWeek,
          onNextWeek: vm.onNextWeek,
        );
      },
    );
  }
}
