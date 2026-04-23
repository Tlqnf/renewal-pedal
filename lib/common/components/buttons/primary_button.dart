import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_radius.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool disabled;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.0,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: disabled
                  ? AppColors.textDisabled
                  : AppColors.primary,
              foregroundColor: AppColors.surface,
              disabledBackgroundColor: AppColors.textDisabled,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
              elevation: 0,
              padding: EdgeInsets.zero,
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (disabled) return AppColors.textDisabled;
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primary200;
                }
                return AppColors.primary;
              }),
            ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.titMd.copyWith(color: AppColors.surface),
          ),
        ),
      ),
    );
  }
}
