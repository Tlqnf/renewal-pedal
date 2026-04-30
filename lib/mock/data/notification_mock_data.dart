import 'package:pedal/domain/notifications/entities/notification_entity.dart';
import 'package:pedal/domain/notifications/enums/notification_type.dart';

class NotificationMockData {
  static final _now = DateTime.now();

  static final List<NotificationEntity> allNotifications = [
    NotificationEntity(
      id: 'notif_001',
      type: NotificationType.notice,
      title: '[공지] 페달 2.0ver 업데이트가 되었습니다.',
      message: '더 빠르고 안정적인 라이딩 경험을 위해 앱이 업데이트되었습니다.',
      date: _formatDate(_now.subtract(const Duration(minutes: 10))),
      timeAgo: '10분 전',
      isRead: false,
    ),
    NotificationEntity(
      id: 'notif_002',
      type: NotificationType.alert,
      title: '[알림] 새 댓글',
      message: '게시글에 새 댓글이 달렸습니다.',
      date: _formatDate(_now.subtract(const Duration(hours: 1))),
      timeAgo: '1시간 전',
      isRead: true,
    ),
    NotificationEntity(
      id: 'notif_003',
      type: NotificationType.alert,
      title: '[알림] 챌린지 시작',
      message: '참가 중인 "4월 100km 완주 챌린지"가 시작되었습니다.',
      date: _formatDate(_now.subtract(const Duration(hours: 3))),
      timeAgo: '3시간 전',
      isRead: false,
    ),
    NotificationEntity(
      id: 'notif_004',
      type: NotificationType.notice,
      title: '[공지] 서비스 점검 안내',
      message: '4월 30일 새벽 2시~4시 서버 점검이 예정되어 있습니다.',
      date: _formatDate(_now.subtract(const Duration(days: 1))),
      timeAgo: '1일 전',
      isRead: true,
    ),
    NotificationEntity(
      id: 'notif_005',
      type: NotificationType.alert,
      title: '[알림] 좋아요',
      message: '회원님의 게시글에 좋아요가 달렸습니다.',
      date: _formatDate(_now.subtract(const Duration(days: 2))),
      timeAgo: '2일 전',
      isRead: false,
    ),
  ];

  static final NotificationEntity sampleNotificationDetail = NotificationEntity(
    id: 'notif_detail_001',
    type: NotificationType.notice,
    title: '[공지] 페달 2.0ver 업데이트가 되었습니다.',
    message:
        '안녕하세요, 페달 팀입니다.\n\n더 빠르고 안정적인 라이딩 경험을 위해 앱이 업데이트되었습니다.\n\n주요 변경사항:\n- 지도 로딩 속도 개선\n- 라이딩 기록 정확도 향상\n- UI/UX 개선',
    date: _formatDate(DateTime.now().subtract(const Duration(minutes: 10))),
    timeAgo: '10분 전',
    isRead: false,
  );

  static String _formatDate(DateTime dt) {
    return '${dt.year}.${dt.month.toString().padLeft(2, '0')}.${dt.day.toString().padLeft(2, '0')}';
  }
}
