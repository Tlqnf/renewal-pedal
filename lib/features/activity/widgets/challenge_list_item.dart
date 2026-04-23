import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';

class ChallengeListItem extends StatelessWidget {
  final ChallengeEntity challenge;
  final VoidCallback onTap;

  const ChallengeListItem({
    super.key,
    required this.challenge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // 원형 썸네일
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.gray100,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: challenge.thumbnailUrl != null
                  ? Image.network(
                      challenge.thumbnailUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
                          const _PlaceholderIcon(),
                    )
                  : const _PlaceholderIcon(),
            ),
            SizedBox(width: AppSpacing.md),
            // 챌린지 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style: AppTextStyles.titXs,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '${_formatDate(challenge.startDate)} ~ ${_formatDate(challenge.endDate)}',
                    style: AppTextStyles.txtXs.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const _TagChip(
                        icon: Icons.emoji_events_outlined,
                        label: '거리',
                      ),
                      SizedBox(width: AppSpacing.sm),
                      _TagChip(
                        icon: Icons.people_outline,
                        label: '${challenge.participantCount}명',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.directions_bike_rounded,
      color: AppColors.gray300,
      size: 32,
    );
  }
}

class _TagChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TagChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 2),
        Text(
          label,
          style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
