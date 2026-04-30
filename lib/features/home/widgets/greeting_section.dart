import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class GreetingSection extends StatelessWidget {
  final String userName;
  final String motivationMessage;

  const GreetingSection({
    super.key,
    required this.userName,
    required this.motivationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$userName님 오늘도 오셨군요!',
            style: AppTextStyles.txtMd.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(motivationMessage, style: AppTextStyles.titXl),
        ],
      ),
    );
  }
}
