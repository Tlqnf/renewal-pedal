import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';

class AppCheckbox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onDetailTap;

  const AppCheckbox({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
    this.onDetailTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: CheckboxItem(
              label: label,
              isChecked: isChecked,
              onChanged: onChanged,
            ),
          ),
          if (onDetailTap != null) ...[
            SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: SvgPicture.asset(
                AppConstants.next,
                width: 48,
                height: 48,
                colorFilter: ColorFilter.mode(
                  AppColors.gray700,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: onDetailTap,
            ),
          ],
        ],
      ),
    );
  }
}

class CheckboxItem extends StatelessWidget {
  final String label;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CheckboxItem({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.primary : AppColors.surface,
              borderRadius: AppRadius.mdAll,
              border: Border.all(
                color: isChecked ? AppColors.primary : AppColors.border,
                width: 2,
              ),
            ),
            child: isChecked
                ? SvgPicture.asset(
                    AppConstants.check,
                    colorFilter: ColorFilter.mode(
                      AppColors.surface,
                      BlendMode.srcIn,
                    ),
                    width: 48,
                    height: 48,
                  )
                : null,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: AppTextStyles.titXs)),
        ],
      ),
    );
  }
}
