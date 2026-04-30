import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class PedalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subSection;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final List<Widget>? extraActions;

  const PedalAppBar({
    super.key,
    required this.title,
    this.subSection,
    this.onSearchTap,
    this.onNotificationTap,
    this.extraActions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0, // 중요
      titleSpacing: 16,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.titMdMedium),
          SizedBox(width: AppSpacing.sm),
          Text(
            subSection ?? '',
            style: AppTextStyles.txtLg.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 24,
          ),
          onPressed: onNotificationTap,
        ),
        ...?extraActions,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
