import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/features/activity/widgets/challenge_banner.dart';
import 'package:pedal/features/activity/widgets/challenge_list_item.dart';

class ChallengeTabView extends StatelessWidget {
  final List<ChallengeEntity> challenges;
  final bool isLoading;
  final String? errorMessage;
  final ActivityStatsEntity stats;
  final void Function(String id) onChallengeTap;

  const ChallengeTabView({
    super.key,
    required this.challenges,
    required this.isLoading,
    required this.errorMessage,
    required this.stats,
    required this.onChallengeTap,
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
          child: ChallengeBanner(stats: stats),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.background,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Text('도전 가능한 챌린지', style: AppTextStyles.titMd),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final challenge = challenges[index];
              return ChallengeListItem(
                challenge: challenge,
                onTap: () => onChallengeTap(challenge.id),
              );
            },
            childCount: challenges.length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
      ],
    );
  }
}
