import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class UserListItem extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String joinDate;
  final bool isFeatured;
  final VoidCallback? onTap;

  const UserListItem({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.joinDate,
    this.isFeatured = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppRadius.lgAll,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: AppColors.textSecondary);
                  },
                ),
              ),
            ),
            SizedBox(width: AppSpacing.lg),
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: AppTextStyles.titSm,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    joinDate,
                    style: AppTextStyles.txtSm,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isFeatured)
              Icon(Icons.star, color: Color(0xFFFFC107), size: 24),
          ],
        ),
      ),
    );
  }
}
