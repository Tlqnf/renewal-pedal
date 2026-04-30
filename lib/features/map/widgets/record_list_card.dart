import 'package:flutter/material.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class RecordListCard extends StatelessWidget {
  final String routeName;
  final double distance;
  final String duration;
  final int calories;
  final VoidCallback? onAction;

  const RecordListCard({
    super.key,
    required this.routeName,
    required this.distance,
    required this.duration,
    required this.calories,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            routeName,
            style: AppTextStyles.titMdMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(value: '${distance.toStringAsFixed(2)} km'),
              _StatItem(value: duration),
              _StatItem(value: '$calories Kcal'),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: "네비게이션 활성화", onPressed: onAction),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;

  const _StatItem({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value, style: AppTextStyles.txtMd, textAlign: TextAlign.center);
  }
}
