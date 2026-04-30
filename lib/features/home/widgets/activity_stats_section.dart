import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';

class ActivityStatsSection extends StatelessWidget {
  final double distanceKm;
  final int calorieKcal;

  const ActivityStatsSection({
    super.key,
    required this.distanceKm,
    required this.calorieKcal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              imagePath: AppConstants.bicycle,
              label: '자전거 거리',
              value: '${distanceKm.toStringAsFixed(0)}km',
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: _StatCard(
              imagePath: AppConstants.icon,
              label: '총칼로리',
              value: '${calorieKcal}kcal',
              useIconFallback: true,
              fallbackIcon: Icons.local_fire_department_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String value;
  final bool useIconFallback;
  final IconData fallbackIcon;

  const _StatCard({
    required this.imagePath,
    required this.label,
    required this.value,
    this.useIconFallback = false,
    this.fallbackIcon = Icons.help_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          useIconFallback
              ? Icon(fallbackIcon, size: 48, color: AppColors.warning)
              : Image.asset(
                  imagePath,
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) =>
                      Icon(fallbackIcon, size: 48, color: AppColors.gray400),
                ),
          SizedBox(height: AppSpacing.sm),
          Text(
            '$label: $value',
            style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
