import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class RecordSummaryCard extends StatelessWidget {
  final String routeName;
  final double distance;
  final String duration;
  final int calories;
  final VoidCallback? onClose;

  const RecordSummaryCard({
    super.key,
    required this.routeName,
    required this.distance,
    required this.duration,
    required this.calories,
    this.onClose,
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
      child: Stack(
        children: [
          Column(
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
                  _StatItem(
                    value: '${distance.toStringAsFixed(2)} km',
                    label: '',
                  ),
                  _StatItem(value: duration, label: ''),
                  _StatItem(value: '$calories Kcal', label: ''),
                ],
              ),
            ],
          ),
          if (onClose != null)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.textDisabled,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTextStyles.txtSm, textAlign: TextAlign.center),
        if (label.isNotEmpty) ...[
          SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTextStyles.txtXs, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}
