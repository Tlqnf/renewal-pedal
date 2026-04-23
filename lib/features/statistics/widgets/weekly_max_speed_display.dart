import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class WeeklyMaxSpeedDisplay extends StatelessWidget {
  final double maxSpeedKmh;

  const WeeklyMaxSpeedDisplay({super.key, required this.maxSpeedKmh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '이번 주 최고 속력',
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.sm),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondary100, width: 3),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: maxSpeedKmh.toStringAsFixed(0),
                      style: AppTextStyles.titMd.copyWith(
                        color: AppColors.secondary400,
                      ),
                    ),
                    TextSpan(
                      text: '\nkm/h',
                      style: AppTextStyles.txtXs.copyWith(
                        color: AppColors.secondary400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
