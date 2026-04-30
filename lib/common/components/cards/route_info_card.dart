import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class RecordInfoCard extends StatelessWidget {
  final String title;
  final String distance;
  final String duration;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;

  const RecordInfoCard({
    super.key,
    required this.title,
    required this.distance,
    required this.duration,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.lgAll,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titMdMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Text(
                      distance,
                      style: AppTextStyles.titXl.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: AppSpacing.lg),
                    Text(
                      duration,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onBookmarkTap != null)
            GestureDetector(
              onTap: onBookmarkTap,
              child: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
