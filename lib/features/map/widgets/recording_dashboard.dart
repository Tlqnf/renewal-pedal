import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class RecordingDashboard extends StatelessWidget {
  final String timeElapsed;
  final double currentSpeed;
  final double totalDistance;

  const RecordingDashboard({
    super.key,
    required this.timeElapsed,
    required this.currentSpeed,
    required this.totalDistance,
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
      child: Row(
        children: [
          Expanded(
            child: _MetricColumn(
              label: '시간',
              value: timeElapsed,
              valueStyle: AppTextStyles.titMdMedium,
            ),
          ),
          Expanded(
            child: _MetricColumn(
              label: '현재 속력 (km/h)',
              value: currentSpeed.toStringAsFixed(2),
              valueStyle: AppTextStyles.titMdMedium,
            ),
          ),
          Expanded(
            child: _MetricColumn(
              label: '거리 (km)',
              value: totalDistance.toStringAsFixed(2),
              valueStyle: AppTextStyles.titMdMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle valueStyle;

  const _MetricColumn({
    required this.label,
    required this.value,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.txtMd, textAlign: TextAlign.center),
        SizedBox(height: AppSpacing.sm),
        Text(value, style: valueStyle, textAlign: TextAlign.center),
      ],
    );
  }
}
