class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String termsDetail = '/terms-detail';
  static const String profileSetting = '/profile-setting';
  static const String home = '/home';
  static const String aiMission = '/ai-mission';
  static const String calendar = '/calendar';
  static const String event = '/event';
  static const String eventDetail = '/event/:eventId';
  static const String eventRequest = '/event/:eventId/request';
  static const String ranking = '/ranking';
  static const String my = '/my';
  static const String myRoutesList = '/my/routes';
  static const String notificationList = '/notification/list';
  static const String notificationDetail = '/notification/detail';
  static const String activityCrewDetail = '/activity/crew/:crewId';

  static String eventDetailPath(String eventId) => '/event/$eventId';
  static String eventRequestPath(String eventId) => '/event/$eventId/request';
  static String activityCrewDetailPath(String crewId) => '/activity/crew/$crewId';
}
