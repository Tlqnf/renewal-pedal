import 'package:flutter/foundation.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/notification/notification_response.dart';

class NotificationRemoteSource {
  final DioClient _client;

  NotificationRemoteSource(this._client);

  Future<List<NotificationResponse>> getNotifications() async {
    debugPrint('[NotificationRemoteSource] GET /notifications');
    final response = await _client.get('/notifications');
    return (response.data as List)
        .map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> readNotification(String notificationId) async {
    debugPrint(
      '[NotificationRemoteSource] PATCH /notifications/$notificationId/read',
    );
    await _client.patch('/notifications/$notificationId/read');
  }

  Future<void> deleteNotification(String notificationId) async {
    debugPrint(
      '[NotificationRemoteSource] DELETE /notifications/$notificationId',
    );
    await _client.delete('/notifications/$notificationId');
  }
}
