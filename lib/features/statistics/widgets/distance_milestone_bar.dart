import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class DistanceMilestoneBar extends StatelessWidget {
  final double todayDistanceKm;
  final List<double> milestoneTargets;

  const DistanceMilestoneBar({
    super.key,
    required this.todayDistanceKm,
    required this.milestoneTargets,
  });

  @override
  Widget build(BuildContext context) {
    final maxTarget = milestoneTargets.isNotEmpty ? milestoneTargets.last : 10.0;
    final progress = (todayDistanceKm / maxTarget).clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // 배경 트랙
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: AppRadius.fullAll,
                    ),
                  ),
                  // 진행 트랙
                  Container(
                    height: 10,
                    width: barWidth * progress,
                    decoration: BoxDecoration(
                      color: AppColors.primary400,
                      borderRadius: AppRadius.fullAll,
                    ),
                  ),
                  // START 라벨
                  Positioned(
                    left: 0,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary400,
                        borderRadius: AppRadius.fullAll,
                      ),
                      child: Text(
                        'START',
                        style: AppTextStyles.txt2xs.copyWith(
                          color: AppColors.gray0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // 마일스톤 포인트
                  ...milestoneTargets.asMap().entries.map((entry) {
                    final target = entry.value;
                    final ratio = target / maxTarget;
                    final xPos = barWidth * ratio;
                    final isAchieved = todayDistanceKm >= target;

                    return Positioned(
                      left: xPos - 12,
                      top: -9,
                      child: Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isAchieved
                                  ? AppColors.warning
                                  : AppColors.gray200,
                              border: Border.all(
                                color: AppColors.gray0,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.monetization_on,
                              size: 14,
                              color: isAchieved
                                  ? AppColors.gray0
                                  : AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),
          SizedBox(height: AppSpacing.lg),
          // 마일스톤 거리 라벨 행
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              ...milestoneTargets.map(
                (target) => Text(
                  '${target.toInt()} km',
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
