import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/features/home/viewmodels/home_view_model.dart';
import 'package:pedal/features/home/widgets/shortcut_menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadData();
    });
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _HomeAppBar(
              formattedBalance: _formatNumber(vm.pointBalance),
              onNotificationTap: () => context.push(AppRoutes.notificationList),
              onMyTap: () => context.push(AppRoutes.my),
            ),
            Expanded(
              child: vm.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroBanner(
                            weatherLabel: vm.weatherLabel,
                            title: vm.bannerTitle,
                            subtitle: vm.bannerSubtitle,
                          ),
                          SizedBox(height: AppSpacing.md),
                          _RideStreakCard(
                            goalWeeks: vm.streakGoalWeeks,
                            currentWeeks: vm.streakCurrentWeeks,
                            currentDays: vm.streakCurrentDays,
                            pointReward: vm.streakPointReward,
                            onCtaTap: () {},
                          ),
                          SizedBox(height: AppSpacing.xl),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            child: Text(
                              '간편 바로가기',
                              style: AppTextStyles.titSmMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          ShortcutMenu(
                            onRankingTap: () => context.push(AppRoutes.ranking),
                            onCalendarTap: () =>
                                context.push(AppRoutes.calendar),
                            onStoreTap: () {},
                          ),
                          SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------

class _HomeAppBar extends StatelessWidget {
  final String formattedBalance;
  final VoidCallback onNotificationTap;
  final VoidCallback onMyTap;

  const _HomeAppBar({
    required this.formattedBalance,
    required this.onNotificationTap,
    required this.onMyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            'P $formattedBalance',
            style: AppTextStyles.titSmMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          _IconButton(
            icon: Icons.mail_outline_rounded,
            onTap: onNotificationTap,
          ),
          SizedBox(width: AppSpacing.xs),
          _IconButton(icon: Icons.person_outline_rounded, onTap: onMyTap),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xs),
        child: Icon(icon, color: AppColors.textPrimary, size: 24),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HeroBanner
// ---------------------------------------------------------------------------

class _HeroBanner extends StatelessWidget {
  final String weatherLabel;
  final String title;
  final String subtitle;

  const _HeroBanner({
    required this.weatherLabel,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        top: AppSpacing.lg,
        bottom: 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 날씨 태그
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppRadius.fullAll,
                  ),
                  child: Text(
                    weatherLabel,
                    style: AppTextStyles.txtXs.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                // 큰 타이틀
                Text(
                  title,
                  style: AppTextStyles.titXl.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                // 서브텍스트
                Text(
                  subtitle,
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
          // 자전거 이미지 (카드 하단에 붙어 살짝 튀어나오는 효과)
          SizedBox(
            width: 140,
            height: 120,
            child: Image.asset(
              AppConstants.bicycle,
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RideStreakCard
// ---------------------------------------------------------------------------

class _RideStreakCard extends StatelessWidget {
  final int goalWeeks;
  final int currentWeeks;
  final int currentDays;
  final int pointReward;
  final VoidCallback onCtaTap;

  const _RideStreakCard({
    required this.goalWeeks,
    required this.currentWeeks,
    required this.currentDays,
    required this.pointReward,
    required this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray200.withValues(alpha: 0.8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '1일만 달리면 $goalWeeks주에요!',
            style: AppTextStyles.titMdBold.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            '🔥 현재 $currentWeeks주 $currentDays일째 진행중',
            style: AppTextStyles.txtSm.copyWith(color: AppColors.secondary),
          ),
          SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: onCtaTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              elevation: 0,
            ),
            child: Text(
              '기록 유지하기 가기',
              style: AppTextStyles.titXs.copyWith(color: AppColors.surface),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            '+${pointReward}P 획득 가능 (오늘 한정)',
            style: AppTextStyles.txtXs.copyWith(color: AppColors.gray500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
