import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/core/constants/constants.dart';

class HomeHeaderBar extends StatelessWidget {
  final String? profileImageUrl;
  final Widget? leftContent;
  final List<Widget> actions;

  const HomeHeaderBar({
    super.key,
    this.profileImageUrl,
    this.leftContent,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.gray200,
              borderRadius: AppRadius.fullAll,
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: AppRadius.fullAll,
              child: profileImageUrl != null
                  ? Image.network(
                      profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _ProfilePlaceholder(),
                    )
                  : Image.asset(
                      AppConstants.icon,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _ProfilePlaceholder(),
                    ),
            ),
          ),
          if (leftContent != null) ...[
            SizedBox(width: AppSpacing.sm),
            leftContent!,
          ],
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.person_rounded, color: AppColors.gray500, size: 24);
  }
}
