import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background message: ${message.messageId}');
  debugPrint('[FCM] Background data: ${message.data}');
  debugPrint('[FCM] Background notification: ${message.notification?.title}');
}

class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// 앱 시작 시 호출 — 권한 요청 없이 핸들러만 등록
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('[FCM] Foreground message: ${message.messageId}');
      debugPrint('[FCM] Foreground data: ${message.data}');
      if (message.notification != null) {
        debugPrint('[FCM] Notification title: ${message.notification?.title}');
        debugPrint('[FCM] Notification body: ${message.notification?.body}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('[FCM] Notification tapped: ${message.messageId}');
      debugPrint('[FCM] Tapped data: ${message.data}');
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        '[FCM] App opened from terminated via notification: ${initialMessage.messageId}',
      );
    }
  }

  /// 광고성 푸시 알림 동의 시에만 호출 — OS 알림 권한 요청 + 토큰 발급
  Future<void> requestPermissionAndRegister() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      final token = await getToken();
      debugPrint('[FCM] Token: $token');
    }
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
}
