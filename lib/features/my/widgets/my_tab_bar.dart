import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class MyTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const MyTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  static const _tabs = ['프로필', '활동내역'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final isSelected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(i),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                ),
              ),
              child: Text(
                _tabs[i],
                textAlign: TextAlign.center,
                style: AppTextStyles.titXs.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
