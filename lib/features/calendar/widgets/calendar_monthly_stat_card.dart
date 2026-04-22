import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/calendar/entities/calendar_monthly_stats_entity.dart';

class CalendarMonthlyStatCard extends StatelessWidget {
  final CalendarMonthlyStatsEntity stats;

  const CalendarMonthlyStatCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final h = stats.totalDurationMinutes ~/ 60;
    final m = stats.totalDurationMinutes % 60;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary100,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${stats.month}월 통계',
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _StatItem(label: '주행거리', value: '${stats.totalDistanceKm.toStringAsFixed(1)}km'),
              _StatItem(label: '평균페이스', value: stats.avgPace),
              _StatItem(label: '시간', value: '${h}h ${m}m'),
              _StatItem(label: '소모칼로리', value: '${stats.totalCalorieKcal}kcal'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.txt2xs.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
