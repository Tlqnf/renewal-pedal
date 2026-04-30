import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/common/layouts/main_scaffold.dart';
import 'package:pedal/features/auth/viewmodels/auth_viewmodel.dart';

import 'package:pedal/features/auth/pages/splash_page.dart';
import 'package:pedal/features/auth/pages/login_page.dart';
import 'package:pedal/features/auth/pages/terms_description_page.dart';
import 'package:pedal/features/auth/pages/profile_setting_page.dart';
import 'package:pedal/features/auth/viewmodels/initial_profile_viewmodel.dart';

import 'package:pedal/features/home/pages/home_page.dart';
import 'package:pedal/features/feed/pages/feed_page.dart';
import 'package:pedal/features/map/pages/map_page.dart';
import 'package:pedal/features/crew/pages/crew_page.dart';
import 'package:pedal/features/crew/pages/crew_detail_page.dart';
import 'package:pedal/features/statistics/pages/statistics_page.dart';

import 'package:pedal/features/calendar/pages/calendar_page.dart';
import 'package:pedal/features/calendar/viewmodels/calendar_view_model.dart';
import 'package:pedal/features/event/pages/event_page.dart';
import 'package:pedal/features/event/pages/event_detail_page.dart';
import 'package:pedal/features/event/pages/event_request_page.dart';
import 'package:pedal/features/event/viewmodels/event_view_model.dart';
import 'package:pedal/features/event/viewmodels/event_detail_view_model.dart';
import 'package:pedal/features/event/viewmodels/event_request_view_model.dart';
import 'package:pedal/features/ranking/pages/ranking_page.dart';
import 'package:pedal/features/ranking/viewmodels/ranking_view_model.dart';

import 'package:pedal/features/my/pages/my_page.dart';
import 'package:pedal/features/my/pages/my_crew_list_page.dart';
import 'package:pedal/features/my/pages/my_feed_list_page.dart';
import 'package:pedal/features/my/pages/my_feed_detail_page.dart';
import 'package:pedal/features/my/pages/settings_page.dart';
import 'package:pedal/features/map/pages/map_search_page.dart';
import 'package:pedal/features/map/pages/record_page.dart';
import 'package:pedal/features/map/pages/routing_feed_detail_page.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';
import 'package:pedal/features/map/viewmodels/map_search_viewmodel.dart';
import 'package:pedal/features/notification/pages/notification_list_page.dart';
import 'package:pedal/features/notification/pages/notification_detail_page.dart';
import 'package:pedal/features/report/pages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:pedal/features/my/pages/my_routes_list_page.dart';
import 'package:pedal/features/my/viewmodels/my_routes_list_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_view_model.dart';

class AppRouter {
  static GoRouter createRouter(AuthViewModel authViewModel) => GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authViewModel,
    redirect: (context, state) {
      final s = authViewModel.state;
      final loc = state.uri.toString();

      if (s == AuthState.initial || s == AuthState.loading) return null;

      if (s == AuthState.loggedOut) {
        return loc == AppRoutes.login ? null : AppRoutes.login;
      }
      if (s == AuthState.needsProfileSetup) {
        return loc == AppRoutes.profileSetting
            ? null
            : AppRoutes.profileSetting;
      }
      if (s == AuthState.loggedIn &&
          (loc == AppRoutes.login ||
              loc == AppRoutes.splash ||
              loc == AppRoutes.profileSetting)) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 0: 홈
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          // 1: 피드
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.feed,
                builder: (context, state) => const FeedPage(),
              ),
            ],
          ),
          // 2: 지도
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.map,
                builder: (context, state) => const MapPage(),
              ),
            ],
          ),
          // 3: 활동
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.activity,
                builder: (context, state) => const ActivityPage(),
              ),
            ],
          ),
          // 4: 통계
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.statistics,
                builder: (context, state) => const StatisticsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.termsDetail,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final title = extra['title'] as String? ?? '';
          final sections = extra['sections'] as List<TermsSection>? ?? [];
          return TermsDescriptionPage(
            termsTitle: title,
            sections: sections,
            isLoading: false,
            onBackPressed: () => context.pop(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.profileSetting,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<InitialProfileViewModel>(),
          child: const ProfileSettingPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<CalendarViewModel>(),
          child: CalendarPage(
            onBack: () => context.pop(),
            currentNavIndex: 0,
            onNavTap: (_) {},
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.event,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<EventViewModel>(),
          child: EventPage(
            onBack: () => context.pop(),
            onDetailTap: () =>
                context.push(AppRoutes.eventDetailPath('event_1')),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.eventDetail,
        builder: (context, state) {
          final eventId = state.pathParameters['eventId'] ?? '';
          return ChangeNotifierProvider.value(
            value: context.read<EventDetailViewModel>(),
            child: EventDetailPage(
              eventId: eventId,
              onBack: () => context.pop(),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.eventRequest,
        builder: (context, state) {
          final eventId = state.pathParameters['eventId'] ?? '';
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ChangeNotifierProvider.value(
            value: context.read<EventRequestViewModel>(),
            child: EventRequestPage(
              eventId: eventId,
              eventTitle: extra['eventTitle'] as String? ?? '',
              eventThumbnailUrl: extra['eventThumbnailUrl'] as String?,
              onBack: () => context.pop(),
              onSubmitSuccess: () => context.go(AppRoutes.home),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.ranking,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<RankingViewModel>(),
          child: RankingPage(
            onBack: () => context.pop(),
            currentNavIndex: 0,
            onNavTap: (_) {},
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.my,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<MyViewModel>(),
          child: MyPage(
            onBack: () => context.pop(),
            onSettingsTap: () => context.push(AppRoutes.settings),
            onCrewTap: (_) => context.push(AppRoutes.myCrewList),
            onRouteTap: (_) => context.push(AppRoutes.myRoutesList),
            onPostTap: (feedId) =>
                context.push(AppRoutes.myFeedDetailPath(feedId)),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.myRoutesList,
        builder: (context, state) => const _MyRoutesScreen(),
      ),
      GoRoute(
        path: AppRoutes.activityCrewDetail,
        builder: (context, state) {
          final crewId = state.pathParameters['crewId'] ?? '';
          return ActivityCrewDetailPage(
            crewId: crewId,
            onBackTap: () => context.pop(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.mapSearch,
        builder: (context, state) => ChangeNotifierProvider.value(
          value: context.read<MapSearchViewModel>(),
          child: const MapSearchPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.record,
        builder: (context, state) =>
            RecordPage(mapViewModel: context.read<MapViewModel>()),
      ),
      GoRoute(
        path: AppRoutes.routingFeedDetail,
        builder: (context, state) {
          final routeId = state.pathParameters['routeId'] ?? '';
          return RoutingFeedDetailPage(routeId: routeId);
        },
      ),
      GoRoute(
        path: AppRoutes.myCrewList,
        builder: (context, state) => const MyCrewListPage(),
      ),
      GoRoute(
        path: AppRoutes.myFeedList,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return MyFeedListPage(
            userId: extra['userId'] as String? ?? '',
            userName: extra['userName'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.myFeedDetail,
        builder: (context, state) {
          final feedId = state.pathParameters['feedId'] ?? '';
          return MyFeedDetailPage(feedId: feedId);
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.notificationList,
        builder: (context, state) => const NotificationListPage(),
      ),
      GoRoute(
        path: AppRoutes.notificationDetail,
        builder: (context, state) {
          final notificationId = state.pathParameters['notificationId'] ?? '';
          return NotificationDetailPage(notificationId: notificationId);
        },
      ),
      GoRoute(
        path: AppRoutes.report,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ReportPage(
            targetType: extra['targetType'] as String? ?? '',
            targetId: extra['targetId'] as String? ?? '',
          );
        },
      ),
    ],
  );
}

class _MyRoutesScreen extends StatefulWidget {
  const _MyRoutesScreen();

  @override
  State<_MyRoutesScreen> createState() => _MyRoutesScreenState();
}

class _MyRoutesScreenState extends State<_MyRoutesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyRoutesListViewModel>().fetchRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRoutesListViewModel>(
      builder: (context, vm, _) => MyRoutesListPage(
        routeList: vm.routeList,
        routeCount: vm.routeCount,
        isLoading: vm.isLoading,
        errorMessage: vm.errorMessage,
        onBack: () => context.pop(),
        onRouteTap: (id) {},
      ),
    );
  }
}
