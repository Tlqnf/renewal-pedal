import 'package:flutter/material.dart';
import 'package:pedal/common/components/navigation/app_bottom_nav_bar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/constants/constants.dart';

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
      appBar: _MainAppBar(
        pointBalance: pointBalance,
        onPointChargeTap: onPointChargeTap,
        onEventTap: onEventTap,
        onNotificationTap: onNotificationTap,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EventBanner(onTap: onBannerTap),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _GreetingSection(
                          userName: userName,
                          motivationMessage: motivationMessage,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ActivityStatsRow(
                          distanceKm: todayDistanceKm,
                          calorieKcal: todayCalorieKcal,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _AiMissionCard(
                          title: aiMissionTitle,
                          description: aiMissionDescription,
                          onCtaTap: onAiMissionCtaTap,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _ShortcutMenu(
                          onStoreTap: onStoreTap,
                          onCalendarTap: onCalendarTap,
                          onRankingTap: onRankingTap,
                          onAiMissionTap: onAiMissionTap,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentNavIndex,
        onTap: onNavTap,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      titleSpacing: AppSpacing.md,
      title: _ProfilePoint(pointBalance: pointBalance),
      actions: [
        IconButton(
          onPressed: onPointChargeTap,
          icon: const Icon(
            Icons.bolt_rounded,
            color: AppColors.textPrimary,
          ),
          tooltip: '포인트 충전소',
        ),
        IconButton(
          onPressed: onEventTap,
          icon: const Icon(
            Icons.campaign_rounded,
            color: AppColors.textPrimary,
          ),
          tooltip: '이벤트',
        ),
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
          ),
          tooltip: '알림',
        ),
        const SizedBox(width: AppSpacing.xs),
      ],
    );
  }
}

class _ProfilePoint extends StatelessWidget {
  final int pointBalance;

  const _ProfilePoint({required this.pointBalance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 원형 프로필 이미지 (50×50)
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray200,
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.gray400,
            size: 28,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '₩${_formatNumber(pointBalance)}',
          style: AppTextStyles.titSm,
        ),
      ],
    );
  }

  String _formatNumber(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}

// ---------------------------------------------------------------------------
// Event Banner
// ---------------------------------------------------------------------------

class _EventBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _EventBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Image.asset(
          AppConstants.event,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Greeting Section
// ---------------------------------------------------------------------------

class _GreetingSection extends StatelessWidget {
  final String userName;
  final String motivationMessage;

  const _GreetingSection({
    required this.userName,
    required this.motivationMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$userName님 오늘도 오셨군요!',
          style: AppTextStyles.titMd,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          motivationMessage,
          style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Activity Stats
// ---------------------------------------------------------------------------

class _ActivityStatsRow extends StatelessWidget {
  final double distanceKm;
  final int calorieKcal;

  const _ActivityStatsRow({
    required this.distanceKm,
    required this.calorieKcal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.directions_bike_rounded,
            iconColor: AppColors.primary,
            value: distanceKm.toStringAsFixed(1),
            unit: 'km',
            label: '오늘 거리',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: AppColors.secondary,
            value: calorieKcal.toString(),
            unit: 'kcal',
            label: '소모 칼로리',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String unit;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.unit,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(value, style: AppTextStyles.titMd),
                  const SizedBox(width: 2),
                  Text(
                    unit,
                    style: AppTextStyles.txtXs.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                label,
                style: AppTextStyles.txtXs.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AI Mission Card
// ---------------------------------------------------------------------------

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
    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            // 배경 이미지
            Positioned.fill(
              child: Image.asset(
                AppConstants.background,
                fit: BoxFit.cover,
              ),
            ),
            // 어두운 오버레이
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
            // 콘텐츠
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titSm.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: AppTextStyles.txtXs.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GestureDetector(
                    onTap: onCtaTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.fullAll,
                      ),
                      child: Text(
                        '라이딩 하러 가기',
                        style: AppTextStyles.txtSm.copyWith(
                          color: AppColors.surface,
                          fontWeight: FontWeight.w600,
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
    );
  }
}

// ---------------------------------------------------------------------------
// Shortcut Menu
// ---------------------------------------------------------------------------

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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
        ],
      ),
    );
  }
}

class _ShortcutItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.txtXs.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
