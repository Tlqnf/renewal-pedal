// TODO: UI 전반 수정
import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';

class MainPage extends StatelessWidget {
  final String userName;
  final int pointBalance;
  final String motivationMessage;
  final double todayDistanceKm;
  final int todayCalorieKcal;
  final String aiMissionTitle;
  final String aiMissionDescription;
  final int currentNavIndex;
  final bool isLoading;
  final ValueChanged<int> onNavTap;
  final VoidCallback onStoreTap;
  final VoidCallback onCalendarTap;
  final VoidCallback onRankingTap;
  final VoidCallback onAiMissionTap;
  final VoidCallback onAiMissionCtaTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onPointChargeTap;
  final VoidCallback onEventTap;
  final VoidCallback onBannerTap;

  const MainPage({
    super.key,
    required this.userName,
    required this.pointBalance,
    required this.motivationMessage,
    required this.todayDistanceKm,
    required this.todayCalorieKcal,
    required this.aiMissionTitle,
    required this.aiMissionDescription,
    required this.currentNavIndex,
    required this.isLoading,
    required this.onNavTap,
    required this.onStoreTap,
    required this.onCalendarTap,
    required this.onRankingTap,
    required this.onAiMissionTap,
    required this.onAiMissionCtaTap,
    required this.onNotificationTap,
    required this.onPointChargeTap,
    required this.onEventTap,
    required this.onBannerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _MainAppBar(
              pointBalance: pointBalance,
              onPointChargeTap: onPointChargeTap,
              onEventTap: onEventTap,
              onNotificationTap: onNotificationTap,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 이벤트 배너
                          _EventBanner(onTap: onBannerTap),

                          // 인사말 + 동기부여 문구
                          _GreetingSection(
                            userName: userName,
                            motivationMessage: motivationMessage,
                          ),

                          // 오늘의 활동 통계
                          _ActivityStatsSection(
                            distanceKm: todayDistanceKm,
                            calorieKcal: todayCalorieKcal,
                          ),

                          SizedBox(height: AppSpacing.md),

                          // AI 미션 카드
                          _AiMissionCard(
                            title: aiMissionTitle,
                            description: aiMissionDescription,
                            onCtaTap: onAiMissionCtaTap,
                          ),

                          SizedBox(height: AppSpacing.md),

                          // 단축 메뉴 그리드
                          _ShortcutMenu(
                            onStoreTap: onStoreTap,
                            onCalendarTap: onCalendarTap,
                            onRankingTap: onRankingTap,
                            onAiMissionTap: onAiMissionTap,
                          ),

                          SizedBox(height: AppSpacing.md),
                        ],
                      ),
                    ),
            ),
            AppBottomNavBar(
              currentIndex: currentNavIndex,
              onTap: onNavTap,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ─────────────────────────────────────────────────

class _MainAppBar extends StatelessWidget {
  final int pointBalance;
  final VoidCallback onPointChargeTap;
  final VoidCallback onEventTap;
  final VoidCallback onNotificationTap;

  const _MainAppBar({
    required this.pointBalance,
    required this.onPointChargeTap,
    required this.onEventTap,
    required this.onNotificationTap,
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
          // 프로필 이미지 (원형)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: AppRadius.fullAll,
              border: Border.all(color: AppColors.border),
            ),
            child: ClipRRect(
              borderRadius: AppRadius.fullAll,
              child: Image.asset(
                AppConstants.icon,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.person_rounded,
                  color: AppColors.gray400,
                  size: 24,
                ),
              ),
            ),
          ),

          SizedBox(width: AppSpacing.sm),

          // 포인트 잔액
          Text(
            '₩ ${_formatNumber(pointBalance)}',
            style: AppTextStyles.titSm.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          const Spacer(),

          // 우측 아이콘들
          _AppBarIconButton(
            icon: Icons.account_balance_wallet_outlined,
            onTap: onPointChargeTap,
          ),
          SizedBox(width: AppSpacing.xs),
          _AppBarIconButton(
            icon: Icons.calendar_today_outlined,
            onTap: onEventTap,
          ),
          SizedBox(width: AppSpacing.xs),
          _AppBarIconButton(
            icon: Icons.notifications_outlined,
            onTap: onNotificationTap,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AppBarIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xs),
        child: Icon(
          icon,
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),
    );
  }
}

// ─── Event Banner ─────────────────────────────────────────────

class _EventBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _EventBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Image.asset(
          AppConstants.event,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: AppColors.primary100,
            child: Center(
              child: Icon(
                Icons.image_outlined,
                color: AppColors.primary,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Greeting Section ─────────────────────────────────────────

class _GreetingSection extends StatelessWidget {
  final String userName;
  final String motivationMessage;

  const _GreetingSection({
    required this.userName,
    required this.motivationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$userName님 오늘도 오셨군요!',
            style: AppTextStyles.txtMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            motivationMessage,
            style: AppTextStyles.titXl,
          ),
        ],
      ),
    );
  }
}

// ─── Activity Stats Section ───────────────────────────────────

class _ActivityStatsSection extends StatelessWidget {
  final double distanceKm;
  final int calorieKcal;

  const _ActivityStatsSection({
    required this.distanceKm,
    required this.calorieKcal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              imagePath: AppConstants.bicycle,
              label: '자전거 거리',
              value: '${distanceKm.toStringAsFixed(0)}km',
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: _StatCard(
              // TODO: AppConstants.calorie 아이콘 추가 필요
              imagePath: AppConstants.icon,
              label: '총칼로리',
              value: '${calorieKcal}kcal',
              useIconFallback: true,
              fallbackIcon: Icons.local_fire_department_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String value;
  final bool useIconFallback;
  final IconData fallbackIcon;

  const _StatCard({
    required this.imagePath,
    required this.label,
    required this.value,
    this.useIconFallback = false,
    this.fallbackIcon = Icons.help_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          useIconFallback
              ? Icon(
                  fallbackIcon,
                  size: 48,
                  color: AppColors.warning,
                )
              : Image.asset(
                  imagePath,
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    fallbackIcon,
                    size: 48,
                    color: AppColors.gray300,
                  ),
                ),
          SizedBox(height: AppSpacing.sm),
          Text(
            '$label: $value',
            style: AppTextStyles.txtSm.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── AI Mission Card ──────────────────────────────────────────

class _AiMissionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onCtaTap;

  const _AiMissionCard({
    required this.title,
    required this.description,
    required this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: SizedBox(
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 배경 이미지
              Image.asset(
                AppConstants.background,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.primary100,
                ),
              ),

              // 반투명 오버레이
              // TODO: AppColors.overlayDark 추가 필요
              Container(
                color: AppColors.gray900.withValues(alpha: 0.25),
              ),

              // 컨텐츠
              Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titMd.copyWith(
                        color: AppColors.gray0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      description,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.gray100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSpacing.md),
                    GestureDetector(
                      onTap: onCtaTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppRadius.fullAll,
                        ),
                        child: Text(
                          '라이딩 하러 가기',
                          style: AppTextStyles.titXs.copyWith(
                            color: AppColors.gray0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Shortcut Menu ────────────────────────────────────────────

class _ShortcutMenu extends StatelessWidget {
  final VoidCallback onStoreTap;
  final VoidCallback onCalendarTap;
  final VoidCallback onRankingTap;
  final VoidCallback onAiMissionTap;

  const _ShortcutMenu({
    required this.onStoreTap,
    required this.onCalendarTap,
    required this.onRankingTap,
    required this.onAiMissionTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _ShortcutItem(
        imagePath: AppConstants.shop,
        label: '상점',
        onTap: onStoreTap,
      ),
      _ShortcutItem(
        imagePath: AppConstants.calendar,
        label: '캘린더',
        onTap: onCalendarTap,
      ),
      _ShortcutItem(
        imagePath: AppConstants.ranking,
        label: '랭킹',
        onTap: onRankingTap,
      ),
      _ShortcutItem(
        imagePath: AppConstants.mission,
        label: 'AI미션',
        onTap: onAiMissionTap,
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: items
            .map(
              (item) => Expanded(child: _ShortcutItemWidget(item: item)),
            )
            .toList(),
      ),
    );
  }
}

class _ShortcutItem {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });
}

class _ShortcutItemWidget extends StatelessWidget {
  final _ShortcutItem item;

  const _ShortcutItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.lgAll,
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Icon(
                  Icons.grid_view_rounded,
                  color: AppColors.gray300,
                  size: 32,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            item.label,
            style: AppTextStyles.txtXs.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
