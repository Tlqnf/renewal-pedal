import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';

class ShortcutMenu extends StatelessWidget {
  final VoidCallback onStoreTap;
  final VoidCallback onCalendarTap;
  final VoidCallback onRankingTap;

  const ShortcutMenu({
    super.key,
    required this.onStoreTap,
    required this.onCalendarTap,
    required this.onRankingTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _ShortcutItem(
        imagePath: AppConstants.shop,
        label: '상점',
        onTap: onStoreTap,
      ),
      _ShortcutItem(
        imagePath: AppConstants.calendar,
        label: '캘린더',
        onTap: onCalendarTap,
      ),
      _ShortcutItem(
        imagePath: AppConstants.ranking,
        label: '랭킹',
        onTap: onRankingTap,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: items
            .map((item) => Expanded(child: _ShortcutItemWidget(item: item)))
            .toList(),
      ),
    );
  }
}

class _ShortcutItem {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });
}

class _ShortcutItemWidget extends StatelessWidget {
  final _ShortcutItem item;

  const _ShortcutItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.lgAll,
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Icon(
                  Icons.grid_view_rounded,
                  color: AppColors.gray400,
                  size: 32,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            item.label,
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
