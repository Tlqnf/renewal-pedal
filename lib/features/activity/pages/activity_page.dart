import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/features/activity/pages/challenge_tab_view.dart';
import 'package:pedal/features/activity/pages/crew_tab_view.dart';
import 'package:pedal/features/activity/viewmodels/activity_view_model.dart';

// ─── Pure View (props-driven, no ViewModel) ───────────────────

class ActivityPage extends StatelessWidget {
  final List<ChallengeEntity> challenges;
  final bool isLoadingChallenges;
  final List<CrewEntity> crews;
  final bool isLoadingCrews;
  final ActivityStatsEntity stats;
  final String userName;
  final String? errorMessage;

  final void Function(String id) onChallengeTap;
  final void Function(String id) onCrewTap;
  final VoidCallback onCreateChallenge;
  final VoidCallback onCreateCrew;
  final VoidCallback onSearch;
  final VoidCallback onNotification;
  final VoidCallback onSettings;

  const ActivityPage({
    super.key,
    required this.challenges,
    required this.isLoadingChallenges,
    required this.crews,
    required this.isLoadingCrews,
    required this.stats,
    required this.userName,
    required this.errorMessage,
    required this.onChallengeTap,
    required this.onCrewTap,
    required this.onCreateChallenge,
    required this.onCreateCrew,
    required this.onSearch,
    required this.onNotification,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: _ActivityAppBar(
              onSearch: onSearch,
              onNotification: onNotification,
              onSettings: onSettings,
            ),
            body: TabBarView(
              children: [
                ChallengeTabView(
                  challenges: challenges,
                  isLoading: isLoadingChallenges,
                  errorMessage: errorMessage,
                  stats: stats,
                  onChallengeTap: onChallengeTap,
                ),
                CrewTabView(
                  crews: crews,
                  isLoading: isLoadingCrews,
                  errorMessage: errorMessage,
                  stats: stats,
                  userName: userName,
                  onCrewTap: onCrewTap,
                ),
              ],
            ),
            floatingActionButton: AnimatedBuilder(
              animation: tabController,
              builder: (context, _) {
                final isChallengeTab = tabController.index == 0;
                return FloatingActionButton(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  onPressed:
                      isChallengeTab ? onCreateChallenge : onCreateCrew,
                  child: const Icon(Icons.add),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ─── AppBar ───────────────────────────────────────────────────

class _ActivityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearch;
  final VoidCallback onNotification;
  final VoidCallback onSettings;

  const _ActivityAppBar({
    required this.onSearch,
    required this.onNotification,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: AppSpacing.md,
      title: Text('활동', style: AppTextStyles.titMd),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textPrimary),
          onPressed: onSearch,
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textPrimary,
          ),
          onPressed: onNotification,
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.textPrimary,
          ),
          onPressed: onSettings,
          splashRadius: 20,
        ),
        SizedBox(width: AppSpacing.xs),
      ],
      bottom: const TabBar(
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textDisabled,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(text: '챌린지'),
          Tab(text: '크루'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}

// ─── Connected (ViewModel 연결) ───────────────────────────────

class ActivityPageConnected extends StatefulWidget {
  const ActivityPageConnected({super.key});

  @override
  State<ActivityPageConnected> createState() => _ActivityPageConnectedState();
}

class _ActivityPageConnectedState extends State<ActivityPageConnected> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityViewModel>(
      builder: (context, vm, _) {
        return ActivityPage(
          challenges: vm.challenges,
          isLoadingChallenges: vm.isLoadingChallenges,
          crews: vm.crews,
          isLoadingCrews: vm.isLoadingCrews,
          stats: vm.stats,
          userName: vm.userName,
          errorMessage: vm.errorMessage,
          onChallengeTap: vm.onChallengeTap,
          onCrewTap: vm.onCrewTap,
          onCreateChallenge: vm.onCreateChallenge,
          onCreateCrew: vm.onCreateCrew,
          onSearch: vm.onSearch,
          onNotification: vm.onNotification,
          onSettings: vm.onSettings,
        );
      },
    );
  }
}
