import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class StatisticsMotivationBanner extends StatelessWidget {
  final double todayDistanceKm;
  final String motivationMessage;

  const StatisticsMotivationBanner({
    super.key,
    required this.todayDistanceKm,
    required this.motivationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB3D9F7),
            Color(0xFFD6EEFF),
          ],
        ),
      ),
      child: Stack(
        children: [
          // 배경 구름/일러스트 장식
          Positioned(
            top: 12,
            right: 16,
            child: Icon(
              Icons.cloud,
              color: AppColors.gray0.withValues(alpha: 0.7),
              size: 40,
            ),
          ),
          Positioned(
            top: 40,
            right: 60,
            child: Icon(
              Icons.cloud,
              color: AppColors.gray0.withValues(alpha: 0.5),
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  motivationMessage,
                  style: AppTextStyles.titSm.copyWith(
                    color: AppColors.gray700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: todayDistanceKm.toStringAsFixed(2),
                        style: AppTextStyles.tit2xl.copyWith(
                          color: AppColors.primary500,
                          fontSize: 48,
                        ),
                      ),
                      TextSpan(
                        text: ' km',
                        style: AppTextStyles.titLg.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
