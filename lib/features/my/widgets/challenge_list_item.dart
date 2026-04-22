import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';

class ChallengeListItem extends StatelessWidget {
  final ChallengeEntity challenge;
  final VoidCallback onTap;

  const ChallengeListItem({super.key, required this.challenge, required this.onTap});

  String _formatDate(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.flag_rounded, color: AppColors.primary, size: 24),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(challenge.title, style: AppTextStyles.titXs),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '${_formatDate(challenge.startDate)} ~ ${_formatDate(challenge.endDate)}',
                    style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.directions_bike_rounded, size: 12, color: AppColors.textSecondary),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        '${challenge.distanceKm.toStringAsFixed(0)}km',
                        style: AppTextStyles.txt2xs.copyWith(color: AppColors.textSecondary),
                      ),
                      SizedBox(width: AppSpacing.md),
                      const Icon(Icons.people_outline_rounded, size: 12, color: AppColors.textSecondary),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        '${challenge.participantCount}명',
                        style: AppTextStyles.txt2xs.copyWith(color: AppColors.textSecondary),
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
}
