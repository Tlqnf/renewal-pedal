import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String iconAssetPath;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;
  final Color? borderColor;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.iconAssetPath,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: borderColor == null
                ? null
                : Border.all(color: borderColor!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconAssetPath, fit: BoxFit.contain),
                Text(
                  label,
                  style: AppTextStyles.txtMd.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
