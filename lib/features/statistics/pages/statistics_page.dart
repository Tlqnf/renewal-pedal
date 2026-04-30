import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/features/statistics/viewmodels/statistics_view_model.dart';
import 'package:pedal/features/statistics/widgets/statistics_motivation_banner.dart';
import 'package:pedal/features/statistics/widgets/distance_milestone_bar.dart';
import 'package:pedal/features/statistics/widgets/daily_reward_message_card.dart';
import 'package:pedal/features/statistics/widgets/weekly_bar_chart.dart';
import 'package:pedal/features/statistics/widgets/weekly_time_circle_indicator.dart';
import 'package:pedal/features/statistics/widgets/weekly_max_speed_display.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsViewModel>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StatisticsViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.errorMessage != null
          ? Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: AppColors.error),
              ),
            )
          : _buildContent(vm),
    );
  }

  Widget _buildContent(StatisticsViewModel vm) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: StatisticsMotivationBanner(
            todayDistanceKm: vm.todayDistanceKm,
            motivationMessage: vm.motivationMessage,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        SliverToBoxAdapter(
          child: DistanceMilestoneBar(
            todayDistanceKm: vm.todayDistanceKm,
            milestoneTargets: vm.milestoneTargets,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        if (vm.dailyRewardMessage != null)
          SliverToBoxAdapter(
            child: DailyRewardMessageCard(message: vm.dailyRewardMessage!),
          ),
        if (vm.dailyRewardMessage != null)
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        SliverToBoxAdapter(
          child: WeeklyBarChart(
            weeklyStats: vm.weeklyStats,
            selectedWeekStart: vm.selectedWeekStart,
            selectedWeekEnd: vm.selectedWeekEnd,
            onPreviousWeek: vm.onPreviousWeek,
            onNextWeek: vm.onNextWeek,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: WeeklyTimeCircleIndicator(
                    totalDurationSeconds: vm.weeklyTotalDurationSeconds,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: WeeklyMaxSpeedDisplay(
                    maxSpeedKmh: vm.weeklyMaxSpeedKmh,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
      ],
    );
  }
}
