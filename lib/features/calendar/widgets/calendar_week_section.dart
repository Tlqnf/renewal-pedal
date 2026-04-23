import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/calendar/entities/calendar_week_section_entity.dart';
import 'package:pedal/domain/calendar/entities/calendar_ride_log_entity.dart';

class CalendarWeekSection extends StatelessWidget {
  final CalendarWeekSectionEntity section;
  final bool isExpanded;
  final VoidCallback onToggle;

  const CalendarWeekSection({
    super.key,
    required this.section,
    required this.isExpanded,
    required this.onToggle,
  });

  String _formatDate(DateTime d) => '${d.month}월 ${d.day}일';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(
                  '${_formatDate(section.weekStart)} ~ ${_formatDate(section.weekEnd)}',
                  style: AppTextStyles.titXs,
                ),
                const Spacer(),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...section.rideLogs.map((log) => CalendarRideLogItem(log: log)),
        Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}

class CalendarRideLogItem extends StatelessWidget {
  final CalendarRideLogEntity log;

  const CalendarRideLogItem({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.subdirectory_arrow_right,
            size: 16,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: AppSpacing.xs),
          Text(
            '${log.date.month}/${log.date.day}',
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LogStat('${log.distanceKm.toStringAsFixed(1)}km'),
                _LogStat('${log.durationMinutes}분'),
                _LogStat('${log.avgSpeedKmh.toStringAsFixed(1)}km/h'),
                _LogStat('${log.calorieKcal}kcal'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogStat extends StatelessWidget {
  final String value;
  const _LogStat(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(value, style: AppTextStyles.txtXs);
  }
}
