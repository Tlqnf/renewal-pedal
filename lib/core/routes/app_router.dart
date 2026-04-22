import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/features/onboarding/pages/splash_page.dart';
import 'package:pedal/features/onboarding/pages/login_page.dart';
import 'package:pedal/features/onboarding/pages/terms_description_page.dart';
import 'package:pedal/features/onboarding/pages/profile_setting_page.dart';
import 'package:pedal/features/home/pages/home_page.dart';

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
        builder: (context, state) => MainPage(
          userName: '',
          pointBalance: 0,
          motivationMessage: '',
          todayDistanceKm: 0,
          todayCalorieKcal: 0,
          aiMissionTitle: '',
          aiMissionDescription: '',
          currentNavIndex: 0,
          isLoading: false,
          onNavTap: (_) {},
          onStoreTap: () {},
          onCalendarTap: () {},
          onRankingTap: () {},
          onAiMissionTap: () {},
          onAiMissionCtaTap: () {},
          onNotificationTap: () {},
          onPointChargeTap: () {},
          onEventTap: () {},
          onBannerTap: () {},
        ),
      ),
    ],
  );
}
