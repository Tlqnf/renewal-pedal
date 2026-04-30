import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final double height;
  final String title;
  final String? description;
  final String? ctaLabel;
  final VoidCallback? onCtaTap;

  const BannerCard({
    super.key,
    required this.imageUrl,
    this.height = 160,
    required this.title,
    this.description,
    this.ctaLabel,
    this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(color: AppColors.primary300),
            ),
            Container(color: AppColors.gray900.withValues(alpha: 0.25)),
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titMdMedium.copyWith(
                      color: AppColors.gray0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (description != null) ...[
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      description!,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.gray200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (ctaLabel != null && onCtaTap != null) ...[
                    SizedBox(height: AppSpacing.md),
                    GestureDetector(
                      onTap: onCtaTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppRadius.fullAll,
                        ),
                        child: Text(
                          ctaLabel!,
                          style: AppTextStyles.titXs.copyWith(
                            color: AppColors.gray0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
