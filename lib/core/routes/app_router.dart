import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/features/auth/pages/splash_page.dart';
import 'package:pedal/features/auth/pages/login_page.dart';
import 'package:pedal/features/auth/pages/terms_description_page.dart';
import 'package:pedal/features/auth/pages/profile_setting_page.dart';
import 'package:pedal/common/layouts/main_scaffold.dart';
import 'package:pedal/features/ai_mission/pages/ai_mission_page.dart';
import 'package:pedal/features/ai_mission/viewmodels/ai_mission_view_model.dart';
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
import 'package:pedal/domain/ai_mission/use_cases/get_ai_missions_use_case.dart';
import 'package:pedal/domain/ai_mission/use_cases/generate_ai_mission_use_case.dart';
import 'package:pedal/domain/calendar/use_cases/get_calendar_data_use_case.dart';
import 'package:pedal/domain/event/use_cases/get_events_use_case.dart';
import 'package:pedal/domain/event/use_cases/get_event_detail_use_case.dart';
import 'package:pedal/domain/event/use_cases/participate_event_use_case.dart';
import 'package:pedal/domain/event/use_cases/submit_event_request_use_case.dart';
import 'package:pedal/domain/ranking/use_cases/get_ranking_use_case.dart';
import 'package:pedal/data/ai_mission/repositories/ai_mission_repository_impl.dart';
import 'package:pedal/data/calendar/repositories/calendar_repository_impl.dart';
import 'package:pedal/data/event/repositories/event_repository_impl.dart';
import 'package:pedal/data/ranking/repositories/ranking_repository_impl.dart';
import 'package:pedal/features/my/pages/my_page.dart';
import 'package:pedal/features/my/viewmodels/my_view_model.dart';
import 'package:pedal/domain/my/use_cases/get_my_profile_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_my_activity_use_case.dart';
import 'package:pedal/data/my/repositories/my_repository_impl.dart';
import 'package:pedal/features/my/pages/my_routes_list_page.dart';
import 'package:pedal/features/my/viewmodels/my_routes_list_view_model.dart';
import 'package:pedal/domain/my/use_cases/get_saved_routes_use_case.dart';
import 'package:pedal/mock/sources/my_routes_mock_repository.dart';

class AppRouter {
  static GoRouter createRouter() => GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
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
            onBackPressed: () => Navigator.pop(context),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.profileSetting,
        builder: (context, state) => ProfileSettingPage(
          profileImage: null,
          nicknameController: TextEditingController(),
          bioController: TextEditingController(),
          isLoading: false,
          nicknameError: null,
          onPickImage: () {},
          onNicknameChanged: (_) {},
          onBioChanged: (_) {},
          onSubmit: () => context.go(AppRoutes.home),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const MainScaffold(),
      ),
      GoRoute(
        path: AppRoutes.aiMission,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => AiMissionViewModel(
            getAiMissionsUseCase: GetAiMissionsUseCase(AiMissionRepositoryImpl()),
            generateAiMissionUseCase: GenerateAiMissionUseCase(AiMissionRepositoryImpl()),
          ),
          child: AiMissionPage(onClose: () => context.pop()),
        ),
      ),
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => CalendarViewModel(
            getCalendarDataUseCase: GetCalendarDataUseCase(CalendarRepositoryImpl()),
          ),
          child: CalendarPage(
            onBack: () => context.pop(),
            currentNavIndex: 0,
            onNavTap: (_) {},
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.event,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => EventViewModel(
            getEventsUseCase: GetEventsUseCase(EventRepositoryImpl()),
          ),
          child: EventPage(
            onBack: () => context.pop(),
            onDetailTap: () => context.push(AppRoutes.eventDetailPath('event_1')),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.eventDetail,
        builder: (context, state) {
          final eventId = state.pathParameters['eventId'] ?? '';
          return ChangeNotifierProvider(
            create: (_) => EventDetailViewModel(
              getEventDetailUseCase: GetEventDetailUseCase(EventRepositoryImpl()),
              participateEventUseCase: ParticipateEventUseCase(EventRepositoryImpl()),
            ),
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
          return ChangeNotifierProvider(
            create: (_) => EventRequestViewModel(
              submitEventRequestUseCase: SubmitEventRequestUseCase(EventRepositoryImpl()),
            ),
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
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => RankingViewModel(
            getRankingUseCase: GetRankingUseCase(RankingRepositoryImpl()),
          ),
          child: RankingPage(
            onBack: () => context.pop(),
            currentNavIndex: 0,
            onNavTap: (_) {},
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.my,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => MyViewModel(
            getMyProfileUseCase: GetMyProfileUseCase(MyRepositoryImpl()),
            getMyActivityUseCase: GetMyActivityUseCase(MyRepositoryImpl()),
          ),
          child: MyPage(onBack: () => context.pop()),
        ),
      ),
      GoRoute(
        path: AppRoutes.myRoutesList,
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => MyRoutesListViewModel(
            GetSavedRoutesUseCase(MyRoutesMockRepository()),
          )..fetchRoutes(),
          child: Consumer<MyRoutesListViewModel>(
            builder: (context, vm, _) => MyRoutesListPage(
              routeList: vm.routeList,
              routeCount: vm.routeCount,
              isLoading: vm.isLoading,
              errorMessage: vm.errorMessage,
              onBack: () => context.pop(),
              onRouteTap: (id) {},
            ),
          ),
        ),
      ),
    ],
  );
}
