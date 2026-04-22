import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class DailyRewardMessageCard extends StatelessWidget {
  final String message;

  const DailyRewardMessageCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3CD),
              borderRadius: AppRadius.mdAll,
            ),
            child: const Center(
              child: Text(
                '🍗',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.txtSm.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
