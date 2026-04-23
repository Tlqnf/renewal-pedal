import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';

class ChallengeBanner extends StatelessWidget {
  final ActivityStatsEntity stats;

  const ChallengeBanner({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '가족 · 친구 · 동료들과\n챌린지를 만들어 함께 도전하세요',
            style: AppTextStyles.titLg,
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: AppRadius.fullAll,
            ),
            child: Text(
              '운영중인 챌린지',
              style: AppTextStyles.titXs.copyWith(color: AppColors.primary),
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  value: _formatNumber(stats.officialCount),
                  label: '공식 챌린지',
                ),
              ),
              _Divider(),
              Expanded(
                child: _StatItem(
                  value: _formatNumber(stats.unofficialCount),
                  label: '비공식 챌린지',
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
        Text(
          value,
          style: AppTextStyles.titMd,
        ),
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
    return Container(
      width: 1,
      height: 32,
      color: AppColors.border,
    );
  }
}
