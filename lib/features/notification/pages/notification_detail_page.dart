import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/notification/notification_viewmodel.dart';

class NotificationDetailPage extends StatefulWidget {
  final String notificationId;

  const NotificationDetailPage({super.key, required this.notificationId});

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationViewModel>().loadNotificationById(
        widget.notificationId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(
      builder: (context, viewModel, _) {
        final notification = viewModel.notificationDetail;
        if (notification == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: BackAppBar(
            title: '알림 상세',
            onBackPressed: () => Navigator.pop(context),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    Text(
                      notification.title,
                      style: AppTextStyles.titLg.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: AppSpacing.sm),

                    // 날짜
                    Text(
                      notification.date,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    SizedBox(height: AppSpacing.xl),

                    // 내용
                    Text(
                      notification.message,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
