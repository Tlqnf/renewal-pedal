import 'package:pedal/data/models/notification/notification_response.dart';
import 'package:pedal/data/notification/sources/notification_remote_source.dart';
import 'package:pedal/mock/data/notification_mock_data.dart';

class NotificationMockRemoteSource implements NotificationRemoteSource {
  static final _now = DateTime.now();

  static final List<Duration> _offsets = [
    const Duration(minutes: 10),
    const Duration(hours: 1),
    const Duration(hours: 3),
    const Duration(days: 1),
    const Duration(days: 2),
  ];

  @override
  Future<List<NotificationResponse>> getNotifications() async {
    final notifications = NotificationMockData.allNotifications;
    return List.generate(notifications.length, (i) {
      final e = notifications[i];
      return NotificationResponse(
        id: e.id,
        userId: 'user_mock_001',
        title: e.title,
        content: e.message,
        isRead: e.isRead,
        createdAt: _now.subtract(_offsets[i]),
      );
    });
  }

  @override
  Future<void> readNotification(String notificationId) async {}

  @override
  Future<void> deleteNotification(String notificationId) async {}
}
