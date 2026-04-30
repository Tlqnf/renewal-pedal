import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/statistics/entities/daily_stat_entity.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<DailyStatEntity> weeklyStats;
  final DateTime selectedWeekStart;
  final DateTime selectedWeekEnd;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const WeeklyBarChart({
    super.key,
    required this.weeklyStats,
    required this.selectedWeekStart,
    required this.selectedWeekEnd,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  String _formatDateHeader(DateTime start, DateTime end) {
    final startStr = '${start.year} ${start.month}월 ${start.day}일';
    final endStr = '${end.year} ${end.month}월 ${end.day}일';
    return '$startStr ~ $endStr';
  }

  @override
  Widget build(BuildContext context) {
    final maxDistance = weeklyStats.isNotEmpty
        ? weeklyStats.map((s) => s.distanceKm).reduce((a, b) => a > b ? a : b)
        : 40.0;
    final chartMax = (maxDistance / 10).ceil() * 10.0;
    final today = DateTime.now();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray300,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더: 날짜 범위 + 화살표
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _formatDateHeader(selectedWeekStart, selectedWeekEnd),
                  style: AppTextStyles.titXs.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onPreviousWeek,
                    child: Icon(
                      Icons.chevron_left,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  GestureDetector(
                    onTap: onNextWeek,
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          // 차트 영역
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y축 라벨
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${chartMax.toInt()}km',
                      style: AppTextStyles.txt2xs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${(chartMax / 2).toInt()}km',
                      style: AppTextStyles.txt2xs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '0km',
                      style: AppTextStyles.txt2xs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: AppSpacing.sm),
                // 바 차트
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyStats.asMap().entries.map((entry) {
                      final stat = entry.value;
                      final isToday =
                          stat.date.year == today.year &&
                          stat.date.month == today.month &&
                          stat.date.day == today.day;
                      final barRatio = chartMax > 0
                          ? stat.distanceKm / chartMax
                          : 0.0;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: FractionallySizedBox(
                                  heightFactor: barRatio.clamp(0.0, 1.0),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isToday
                                          ? AppColors.primary
                                          : AppColors.primary400,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: AppSpacing.xs),
                              Text(
                                '${stat.date.day}',
                                style: AppTextStyles.txt2xs.copyWith(
                                  color: isToday
                                      ? AppColors.primary400
                                      : AppColors.textSecondary,
                                  fontWeight: isToday
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
