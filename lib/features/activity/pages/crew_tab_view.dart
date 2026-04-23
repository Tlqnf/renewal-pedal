import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/features/activity/widgets/activity_stats_summary_card.dart';
import 'package:pedal/features/activity/widgets/crew_card.dart';

class CrewTabView extends StatelessWidget {
  final List<CrewEntity> crews;
  final bool isLoading;
  final String? errorMessage;
  final ActivityStatsEntity stats;
  final String userName;
  final void Function(String id) onCrewTap;

  const CrewTabView({
    super.key,
    required this.crews,
    required this.isLoading,
    required this.errorMessage,
    required this.stats,
    required this.userName,
    required this.onCrewTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: AppTextStyles.txtSm.copyWith(color: AppColors.error),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ActivityStatsSummaryCard(stats: stats),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Text(
              '$userName님의 크루 추천',
              style: AppTextStyles.titMd,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final crew = crews[index];
                return CrewCard(
                  crew: crew,
                  onTap: () => onCrewTap(crew.id),
                );
              },
              childCount: crews.length,
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
      ],
    );
  }
}
