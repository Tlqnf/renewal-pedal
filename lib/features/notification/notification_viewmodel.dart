import 'package:flutter/material.dart';
import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/notifications/use_cases/get_notifications_usecase.dart';
import 'package:pedal/domain/notifications/use_cases/read_notification_usecase.dart';

class NotificationViewModel extends ChangeNotifier {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final ReadNotificationUseCase _readNotificationUseCase;

  NotificationViewModel(
    this._getNotificationsUseCase,
    this._readNotificationUseCase,
  );

  List<NotificationEntity> _notifications = [];
  NotificationEntity? _notificationDetail;
  bool _isLoading = false;
  String? _errorMessage;

  List<NotificationEntity> get notifications => _notifications;
  NotificationEntity? get notificationDetail => _notificationDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getNotificationsUseCase.execute();

    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _notifications = list,
    );

    _isLoading = false;
    notifyListeners();
  }

  // ID 기반으로 알림 상세 로드 + 읽음 처리
  Future<void> loadNotificationById(String id) async {
    _notificationDetail = _notifications.firstWhere(
      (n) => n.id == id,
      orElse: () => _notifications.first,
    );
    notifyListeners();

    await markAsRead(id);
  }

  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1 || _notifications[index].isRead) return;

    await _readNotificationUseCase.execute(notificationId);

    final n = _notifications[index];
    _notifications[index] = NotificationEntity(
      id: n.id,
      type: n.type,
      title: n.title,
      message: n.message,
      date: n.date,
      timeAgo: n.timeAgo,
      isRead: true,
    );
    notifyListeners();
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) {
      return NotificationEntity(
        id: n.id,
        type: n.type,
        title: n.title,
        message: n.message,
        date: n.date,
        timeAgo: n.timeAgo,
        isRead: true,
      );
    }).toList();
    notifyListeners();
  }
}
