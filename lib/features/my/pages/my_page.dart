import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/features/my/viewmodels/my_view_model.dart';
import 'package:pedal/features/my/widgets/my_tab_bar.dart';
import 'package:pedal/features/my/widgets/profile_header_section.dart';
import 'package:pedal/features/my/widgets/riding_stats_grid.dart';
import 'package:pedal/features/my/widgets/section_header.dart';
import 'package:pedal/features/my/widgets/challenge_list_item.dart';
import 'package:pedal/features/my/widgets/crew_card.dart';
import 'package:pedal/features/my/widgets/saved_route_list_item.dart';

class MyPage extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onInviteFriendTap;
  final ValueChanged<String>? onChallengeTap;
  final ValueChanged<String>? onCrewTap;
  final ValueChanged<String>? onRouteTap;
  final ValueChanged<String>? onPostTap;

  const MyPage({
    super.key,
    required this.onBack,
    this.onSettingsTap,
    this.onInviteFriendTap,
    this.onChallengeTap,
    this.onCrewTap,
    this.onRouteTap,
    this.onPostTap,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyViewModel>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text('My', style: AppTextStyles.titMd),
        centerTitle: true,
      ),
      body: Consumer<MyViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return Column(
            children: [
              Container(
                color: AppColors.surface,
                child: MyTabBar(
                  selectedIndex: vm.selectedTabIndex,
                  onTabChanged: vm.onTabChanged,
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: vm.selectedTabIndex,
                  children: [
                    _ProfileTab(
                      vm: vm,
                      onSettingsTap: widget.onSettingsTap ?? () {},
                      onInviteFriendTap: widget.onInviteFriendTap ?? () {},
                      onPostTap: widget.onPostTap,
                    ),
                    _ActivityTab(
                      vm: vm,
                      onChallengeTap: widget.onChallengeTap,
                      onCrewTap: widget.onCrewTap,
                      onRouteTap: widget.onRouteTap,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── 프로필 탭 ────────────────────────────────────────────────

class _ProfileTab extends StatelessWidget {
  final MyViewModel vm;
  final VoidCallback onSettingsTap;
  final VoidCallback onInviteFriendTap;
  final ValueChanged<String>? onPostTap;

  const _ProfileTab({
    required this.vm,
    required this.onSettingsTap,
    required this.onInviteFriendTap,
    this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    final profile = vm.profile;
    if (profile == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.surface,
            child: ProfileHeaderSection(
              profile: profile,
              onSettingsTap: onSettingsTap,
              onReportTap: () {},
              onFollowerTap: () {},
              onFollowingTap: () {},
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          // 친구 초대 배너
          GestureDetector(
            onTap: onInviteFriendTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.lgAll,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_add_alt_1_rounded,
                    color: AppColors.surface,
                    size: 20,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    '친구 초대하고 5000P 받기',
                    style: AppTextStyles.titXs.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: AppColors.surface),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md),
          // 활동 아이콘 행
          Container(
            color: AppColors.surface,
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActivityIcon(
                  emoji: '🔔',
                  label: '알림',
                  count: profile.notificationCount,
                  onTap: () {},
                ),
                _ActivityIcon(
                  emoji: '🔖',
                  label: '스크랩',
                  count: profile.scrapCount,
                  onTap: () {},
                ),
                _ActivityIcon(
                  emoji: '❤️',
                  label: '좋아요',
                  count: profile.likeCount,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.md),
          // 라이딩 통계
          RidingStatsGrid(profile: profile),
          SizedBox(height: AppSpacing.md),
          // 게시물 섹션
          Container(
            color: AppColors.surface,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Text('게시물', style: AppTextStyles.titSm),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        '${profile.postCount}',
                        style: AppTextStyles.titSm.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemCount: profile.postThumbnailUrls.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => onPostTap?.call('post_$index'),
                    child: Container(
                      color: AppColors.gray100,
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: AppColors.gray300,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _ActivityIcon extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;
  final VoidCallback onTap;

  const _ActivityIcon({
    required this.emoji,
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          SizedBox(height: AppSpacing.xs),
          Text(
            '$label $count',
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─── 활동내역 탭 ──────────────────────────────────────────────

class _ActivityTab extends StatelessWidget {
  final MyViewModel vm;
  final ValueChanged<String>? onChallengeTap;
  final ValueChanged<String>? onCrewTap;
  final ValueChanged<String>? onRouteTap;

  const _ActivityTab({
    required this.vm,
    this.onChallengeTap,
    this.onCrewTap,
    this.onRouteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 챌린지
          SectionHeader(
            title: '참여한 챌린지',
            count: vm.challenges.length,
            onMoreTap: () {},
          ),
          ...vm.challenges.map(
            (c) => ChallengeListItem(
              challenge: c,
              onTap: () => onChallengeTap?.call(c.id),
            ),
          ),
          // 크루
          SectionHeader(
            title: '참여한 크루',
            count: vm.crews.length,
            onMoreTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: vm.crews.length,
              itemBuilder: (context, index) => CrewCard(
                crew: vm.crews[index],
                onTap: () => onCrewTap?.call(vm.crews[index].id),
              ),
            ),
          ),
          // 저장된 경로
          SectionHeader(
            title: '저장된 경로',
            count: vm.savedRoutes.length,
            onMoreTap: () {},
          ),
          ...vm.savedRoutes.map(
            (r) => SavedRouteListItem(
              route: r,
              onTap: () => onRouteTap?.call(r.id),
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
