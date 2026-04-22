import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/ai_mission/entities/ai_mission_card_entity.dart';

class AiMissionCardWidget extends StatelessWidget {
  final AiMissionCardEntity mission;

  const AiMissionCardWidget({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: EdgeInsets.only(right: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray300.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: AppColors.primary100,
              child: const Center(
                child: Icon(
                  Icons.directions_bike_rounded,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.title,
                  style: AppTextStyles.titSm,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  mission.description,
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      '${mission.durationDays}일',
                      style: AppTextStyles.txt2xs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
