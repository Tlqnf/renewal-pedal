import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/lists/items/ranking_list_item.dart';
import 'package:pedal/common/components/states/empty_state_view.dart';
import 'package:pedal/common/components/states/loading_state_view.dart';
import 'package:pedal/common/components/states/error_state_view.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/features/crew/viewmodels/crew_detail_view_model.dart';

class ActivityCrewDetailPage extends StatefulWidget {
  final String crewId;
  final VoidCallback onBackTap;

  const ActivityCrewDetailPage({
    super.key,
    required this.crewId,
    required this.onBackTap,
  });

  @override
  State<ActivityCrewDetailPage> createState() => _ActivityCrewDetailPageState();
}

class _ActivityCrewDetailPageState extends State<ActivityCrewDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CrewDetailViewModel>().fetchCrewDetail(widget.crewId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CrewDetailViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(
        title: '크루',
        onBackPressed: widget.onBackTap,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.ios_share_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: vm.isLoading
          ? const LoadingStateView()
          : vm.errorMessage != null
          ? ErrorStateView(message: vm.errorMessage!)
          : vm.crewDetail == null
          ? const SizedBox.shrink()
          : _CrewDetailBody(
              crewDetail: vm.crewDetail!,
              isJoined: vm.isJoined,
              selectedTabIndex: vm.selectedTabIndex,
              memberCount: vm.memberCount,
              crewPoint: vm.crewPoint,
              onJoinCrew: () => vm.onJoinCrew(widget.crewId),
              onTabChanged: vm.onTabChanged,
            ),
    );
  }
}

class _CrewDetailBody extends StatelessWidget {
  final CrewDetailEntity crewDetail;
  final bool isJoined;
  final int selectedTabIndex;
  final int memberCount;
  final int crewPoint;
  final VoidCallback onJoinCrew;
  final void Function(int index) onTabChanged;

  const _CrewDetailBody({
    required this.crewDetail,
    required this.isJoined,
    required this.selectedTabIndex,
    required this.memberCount,
    required this.crewPoint,
    required this.onJoinCrew,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedTabIndex,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: _CrewCoverImageSection(
              coverImageUrl: crewDetail.coverImageUrl,
              crewDetail: crewDetail,
              isJoined: isJoined,
              onJoinCrew: onJoinCrew,
            ),
          ),
          SliverToBoxAdapter(
            child: _CrewStatRow(memberCount: memberCount, crewPoint: crewPoint),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              tabBar: TabBar(
                onTap: onTabChanged,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyles.titXs,
                unselectedLabelStyle: AppTextStyles.txtSm,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: '정보'),
                  Tab(text: '랭킹'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          children: [
            // 정보 탭
            isJoined
                ? _CrewInfoTab(description: crewDetail.description)
                : const _CrewLockedInfoSection(),
            // 랭킹 탭
            _CrewRankingTab(members: crewDetail.memberRankings),
          ],
        ),
      ),
    );
  }
}

class _CrewCoverImageSection extends StatefulWidget {
  final String? coverImageUrl;
  final CrewDetailEntity crewDetail;
  final bool isJoined;
  final VoidCallback onJoinCrew;

  const _CrewCoverImageSection({
    required this.coverImageUrl,
    required this.crewDetail,
    required this.isJoined,
    required this.onJoinCrew,
  });

  @override
  State<_CrewCoverImageSection> createState() => _CrewCoverImageSectionState();
}

class _CrewCoverImageSectionState extends State<_CrewCoverImageSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 커버 이미지
        Container(
          width: double.infinity,
          height: 200,
          color: AppColors.gray300,
          child: widget.coverImageUrl != null
              ? Image.network(
                  widget.coverImageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const _PlaceholderCover(),
                )
              : const _PlaceholderCover(),
        ),
        // 하단 카드 오버랩
        Positioned(
          left: 0,
          right: 0,
          bottom: -8,
          child: _CrewInfoCard(
            crewDetail: widget.crewDetail,
            isJoined: widget.isJoined,
            isExpanded: _isExpanded,
            onJoinCrew: widget.onJoinCrew,
            onToggleExpand: () => setState(() => _isExpanded = !_isExpanded),
          ),
        ),
        // 여백 확보 (카드 오버랩 높이 보정)
        const SizedBox(height: 8),
      ],
    );
  }
}

class _PlaceholderCover extends StatelessWidget {
  const _PlaceholderCover();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray300,
      child: const Center(
        child: Icon(Icons.image_outlined, size: 48, color: AppColors.gray500),
      ),
    );
  }
}

class _CrewInfoCard extends StatelessWidget {
  final CrewDetailEntity crewDetail;
  final bool isJoined;
  final bool isExpanded;
  final VoidCallback onJoinCrew;
  final VoidCallback onToggleExpand;

  const _CrewInfoCard({
    required this.crewDetail,
    required this.isJoined,
    required this.isExpanded,
    required this.onJoinCrew,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 크루명 + 가입하기 버튼
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    crewDetail.name,
                    style: AppTextStyles.titMdMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                if (!isJoined)
                  GestureDetector(
                    onTap: onJoinCrew,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppRadius.lgAll,
                      ),
                      child: Text(
                        '가입하기',
                        style: AppTextStyles.titXs.copyWith(
                          color: AppColors.surface,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // 지역 + 해시태그 칩
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _TagChip(label: crewDetail.location),
                ...crewDetail.hashtags.map((tag) => _TagChip(label: '#$tag')),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // 소개 텍스트
            Text(
              crewDetail.description,
              style: AppTextStyles.txtSm.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: isExpanded ? null : 2,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            // 펼치기/접기 chevron
            Center(
              child: GestureDetector(
                onTap: onToggleExpand,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: AppRadius.fullAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.txt2xs.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

class _CrewStatRow extends StatelessWidget {
  final int memberCount;
  final int crewPoint;

  const _CrewStatRow({required this.memberCount, required this.crewPoint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.lg + AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _StatItem(label: '크루원', value: memberCount),
            ),
            VerticalDivider(color: AppColors.border, width: 1, thickness: 1),
            Expanded(
              child: _StatItem(label: '크루원', value: crewPoint),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(value.toString(), style: AppTextStyles.titXl),
      ],
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const _TabBarDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height + 1;

  @override
  double get maxExtent => tabBar.preferredSize.height + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.surface,
      child: Column(
        children: [
          tabBar,
          Container(height: 1, color: AppColors.border),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) =>
      tabBar != oldDelegate.tabBar;
}

class _CrewInfoTab extends StatelessWidget {
  final String description;

  const _CrewInfoTab({required this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('크루 소개', style: AppTextStyles.titSmMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _CrewLockedInfoSection extends StatelessWidget {
  const _CrewLockedInfoSection();

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      icon: Icons.lock_outline,
      message: '크루 활동 정보가 크루원에게만\n공개되는 크루입니다.\n크루에 가입해 보세요!',
    );
  }
}

class _CrewRankingTab extends StatelessWidget {
  final List<CrewMemberRankingEntity> members;

  const _CrewRankingTab({required this.members});

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const EmptyStateView(message: '랭킹 정보가 없습니다.');
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: members.length,
      separatorBuilder: (_, _) => Divider(height: 1, color: AppColors.border),
      itemBuilder: (context, index) {
        final member = members[index];
        return RankingListItem(
          rank: member.rank,
          profileImageUrl: member.profileImageUrl,
          nickname: member.nickname,
          value: '${member.distanceKm.toStringAsFixed(1)}km',
        );
      },
    );
  }
}
