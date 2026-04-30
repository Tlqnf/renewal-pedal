class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String termsDetail = '/terms-detail';
  static const String profileSetting = '/profile-setting';
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String feed = '/feed';
  static const String event = '/event';
  static const String eventDetail = '/event/:eventId';
  static const String eventRequest = '/event/:eventId/request';
  static const String ranking = '/ranking';
  static const String map = '/map';
  static const String my = '/my';
  static const String myRoutesList = '/my/routes';
  static const String notificationList = '/notification/list';
  static const String notificationDetail = '/notification/:notificationId';
  static const String activity = '/activity';
  static const String activityCrewDetail = '/activity/crew/:crewId';
  static const String statistics = '/statistics';
  static const String mapSearch = '/map/search';
  static const String record = '/map/record';
  static const String routingFeedDetail = '/map/route/:routeId';
  static const String myCrewList = '/my/crews';
  static const String myFeedList = '/my/feeds';
  static const String myFeedDetail = '/my/feeds/:feedId';
  static const String settings = '/my/settings';
  static const String report = '/report';

  static String eventDetailPath(String eventId) => '/event/$eventId';
  static String eventRequestPath(String eventId) => '/event/$eventId/request';
  static String activityCrewDetailPath(String crewId) =>
      '/activity/crew/$crewId';
  static String notificationDetailPath(String notificationId) =>
      '/notification/$notificationId';
  static String routingFeedDetailPath(String routeId) => '/map/route/$routeId';
  static String myFeedDetailPath(String feedId) => '/my/feeds/$feedId';
}
