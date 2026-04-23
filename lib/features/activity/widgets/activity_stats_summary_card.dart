import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';

class ActivityStatsSummaryCard extends StatelessWidget {
  final ActivityStatsEntity stats;

  const ActivityStatsSummaryCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              value: _formatNumber(stats.officialCount),
              label: '전국 챌린지',
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              value: _formatNumber(stats.unofficialCount),
              label: '지역 챌린지',
            ),
          ),
          _Divider(),
          Expanded(
            child: _StatItem(
              value: _formatNumber(stats.totalParticipants),
              label: '전체 참가자',
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.titMd),
        SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: AppColors.border);
  }
}
