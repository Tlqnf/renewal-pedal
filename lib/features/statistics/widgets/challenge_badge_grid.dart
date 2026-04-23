import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/statistics/entities/challenge_badge_entity.dart';

class ChallengeBadgeGrid extends StatelessWidget {
  final List<ChallengeBadgeEntity> badges;

  const ChallengeBadgeGrid({super.key, required this.badges});

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '챌린지 뱃지',
            style: AppTextStyles.titSm.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final badge = badges[index];
              return _BadgeItem(
                badge: badge,
                formattedDate: _formatDate(badge.achievedAt),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final ChallengeBadgeEntity badge;
  final String formattedDate;

  const _BadgeItem({required this.badge, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray100,
            border: Border.all(color: AppColors.gray200, width: 1),
          ),
          child: badge.imageUrl != null
              ? ClipOval(
                  child: Image.network(
                    badge.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Icon(
                      Icons.emoji_events,
                      color: AppColors.warning,
                      size: 32,
                    ),
                  ),
                )
              : Icon(Icons.emoji_events, color: AppColors.warning, size: 32),
        ),
        const SizedBox(height: 4),
        Text(
          badge.title,
          style: AppTextStyles.txt2xs.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '달성',
          style: AppTextStyles.txt2xs.copyWith(
            color: AppColors.primary400,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          formattedDate,
          style: AppTextStyles.txt2xs.copyWith(
            color: AppColors.textSecondary,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}
