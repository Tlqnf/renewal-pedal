import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_colors.dart';

class ActivityIconItem extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;
  final VoidCallback onTap;

  const ActivityIconItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          SizedBox(height: AppSpacing.xs),
          Text(
            '$label $count',
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
