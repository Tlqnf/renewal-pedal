import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onMoreTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.count,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.titSm),
          SizedBox(width: AppSpacing.xs),
          Text(
            '$count',
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onMoreTap,
            child: Text(
              '더보기',
              style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
