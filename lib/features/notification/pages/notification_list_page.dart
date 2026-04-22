import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/cards/notification_card.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/features/notification/notification_viewmodel.dart';
import 'package:pedal/core/routes/app_routes.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationViewModel>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BackAppBar(
        title: '알림',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.errorMessage != null
                ? Center(child: Text(viewModel.errorMessage!))
                : ListView.builder(
                    itemCount: viewModel.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = viewModel.notifications[index];
                      return NotificationCard(
                        type: notification.type,
                        message: notification.message,
                        timeAgo: notification.timeAgo,
                        isRead: notification.isRead,
                        onTap: () {
                          context.push(
                            '${AppRoutes.notificationDetail}?id=${notification.id}',
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
