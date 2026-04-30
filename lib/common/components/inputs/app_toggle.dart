import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final bool enabled;

  const AppToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onChanged(!value) : null,
      child: Container(
        width: 60,
        height: 36,
        padding: EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: value
              ? AppColors.primary
              : (enabled ? AppColors.border : AppColors.textDisabled),
          borderRadius: AppRadius.fullAll,
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.fullAll,
            ),
          ),
        ),
      ),
    );
  }
}
