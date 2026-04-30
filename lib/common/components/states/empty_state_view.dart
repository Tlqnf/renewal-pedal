import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class EmptyStateView extends StatelessWidget {
  final IconData? icon;
  final String message;

  const EmptyStateView({super.key, this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 40, color: AppColors.gray400),
            SizedBox(height: AppSpacing.sm),
          ],
          Text(
            message,
            style: AppTextStyles.txtMd.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
