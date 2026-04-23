import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';

class RidingStatsGrid extends StatelessWidget {
  final MyProfileEntity profile;

  const RidingStatsGrid({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem(
        '🚴',
        '자전거 거리',
        '${profile.ridingDistanceKm.toStringAsFixed(1)}km',
      ),
      _StatItem(
        '🔥',
        '총칼로리',
        '${profile.totalCaloriesKcal.toStringAsFixed(0)}kcal',
      ),
      _StatItem('⏱', '총 시간', '${profile.totalHours}h'),
      _StatItem('📅', '총 일수', '${profile.totalDays}일'),
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary100,
        borderRadius: AppRadius.lgAll,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2.5,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        children: items.map((item) => _StatCell(item: item)).toList(),
      ),
    );
  }
}

class _StatItem {
  final String emoji;
  final String label;
  final String value;
  const _StatItem(this.emoji, this.label, this.value);
}

class _StatCell extends StatelessWidget {
  final _StatItem item;
  const _StatCell({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item.emoji, style: const TextStyle(fontSize: 20)),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.value,
                style: AppTextStyles.titSm.copyWith(
                  color: AppColors.primary500,
                ),
              ),
              Text(
                item.label,
                style: AppTextStyles.txt2xs.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
