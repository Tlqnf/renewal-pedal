import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class CalendarMonthHeader extends StatelessWidget {
  final DateTime focusedMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CalendarMonthHeader({
    super.key,
    required this.focusedMonth,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
          ),
          Text(
            '${focusedMonth.year}년 ${focusedMonth.month}월',
            style: AppTextStyles.titMd,
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
