import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/notifications/enums/notification_type.dart';

class NotificationCard extends StatelessWidget {
  final NotificationType type;
  final String message;
  final String timeAgo;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.type,
    required this.message,
    required this.timeAgo,
    this.isRead = false,
    this.onTap,
  });

  IconData _getIcon() {
    switch (type) {
      case NotificationType.alert:
        return Icons.notifications;
      case NotificationType.notice:
        return Icons.campaign;
    }
  }

  String _getLabel() {
    switch (type) {
      case NotificationType.alert:
        return '[알림]';
      case NotificationType.notice:
        return '[공지]';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: isRead ? AppColors.surface : AppColors.background,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 아이콘 + 배지
            Stack(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRead ? AppColors.background : AppColors.surface,
                  ),
                  child: Icon(
                    _getIcon(),
                    color: isRead
                        ? AppColors.textDisabled
                        : AppColors.textPrimary,
                    size: 24,
                  ),
                ),
                if (!isRead)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: AppSpacing.lg),

            // 텍스트 콘텐츠
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 라벨
                  Text(
                    _getLabel(),
                    style: AppTextStyles.titMd.copyWith(
                      color: isRead
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),

                  // 메시지
                  Text(
                    message,
                    style: AppTextStyles.txtSm.copyWith(
                      color: isRead
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.xs),

                  // 시간
                  Text(
                    timeAgo,
                    style: AppTextStyles.txtSm.copyWith(
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
