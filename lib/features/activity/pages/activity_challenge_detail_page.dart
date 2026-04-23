import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/features/activity/viewmodels/activity_challenge_detail_view_model.dart';

class ActivityChallengeDetailPage extends StatelessWidget {
  final ChallengeDetailEntity? challengeDetail;
  final bool isLoading;
  final String? errorMessage;
  final bool isDescriptionExpanded;
  final int selectedTabIndex;
  final bool isParticipating;
  final List<ChallengeRankingEntity> rankingList;

  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onParticipatePressed;
  final VoidCallback onToggleDescription;
  final ValueChanged<int> onTabChanged;

  const ActivityChallengeDetailPage({
    super.key,
    required this.challengeDetail,
    required this.isLoading,
    required this.errorMessage,
    required this.isDescriptionExpanded,
    required this.selectedTabIndex,
    required this.isParticipating,
    required this.rankingList,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onParticipatePressed,
    required this.onToggleDescription,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: selectedTabIndex,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: BackAppBar(
          title: '챌린지',
          onBackPressed: onBackPressed,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.md),
              child: GestureDetector(
                onTap: onSharePressed,
                child: const Icon(
                  Icons.share_outlined,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : errorMessage != null
            ? Center(
                child: Text(
                  errorMessage!,
                  style: AppTextStyles.txtMd.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              )
            : challengeDetail == null
            ? const SizedBox.shrink()
            : _ChallengeDetailBody(
                challengeDetail: challengeDetail!,
                isDescriptionExpanded: isDescriptionExpanded,
                selectedTabIndex: selectedTabIndex,
                isParticipating: isParticipating,
                rankingList: rankingList,
                onParticipatePressed: onParticipatePressed,
                onToggleDescription: onToggleDescription,
                onTabChanged: onTabChanged,
              ),
      ),
    );
  }
}

class _ChallengeDetailBody extends StatelessWidget {
  final ChallengeDetailEntity challengeDetail;
  final bool isDescriptionExpanded;
  final int selectedTabIndex;
  final bool isParticipating;
  final List<ChallengeRankingEntity> rankingList;
  final VoidCallback onParticipatePressed;
  final VoidCallback onToggleDescription;
  final ValueChanged<int> onTabChanged;

  const _ChallengeDetailBody({
    required this.challengeDetail,
    required this.isDescriptionExpanded,
    required this.selectedTabIndex,
    required this.isParticipating,
    required this.rankingList,
    required this.onParticipatePressed,
    required this.onToggleDescription,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ChallengeDetailBannerSection(
                      imageUrl: challengeDetail.bannerImageUrl,
                    ),
                    _ChallengeDetailInfoCard(
                      challengeDetail: challengeDetail,
                      isDescriptionExpanded: isDescriptionExpanded,
                      isParticipating: isParticipating,
                      onParticipatePressed: onParticipatePressed,
                      onToggleDescription: onToggleDescription,
                    ),
                    _ChallengeStatRow(
                      participantCount: challengeDetail.participantCount,
                      totalDistanceKm: challengeDetail.totalDistanceKm,
                    ),
                    const Divider(height: 1, color: AppColors.divider),
                    _ChallengeTabBar(onTabChanged: onTabChanged),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _InfoTab(challengeDetail: challengeDetail),
                _RankingTab(rankingList: rankingList),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChallengeDetailBannerSection extends StatelessWidget {
  final String? imageUrl;

  const _ChallengeDetailBannerSection({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _BannerPlaceholder(),
            )
          : _BannerPlaceholder(),
    );
  }
}

class _BannerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary100,
      child: const Center(
        child: Icon(
          Icons.directions_bike_rounded,
          color: AppColors.primary,
          size: 64,
        ),
      ),
    );
  }
}

class _ChallengeDetailInfoCard extends StatelessWidget {
  final ChallengeDetailEntity challengeDetail;
  final bool isDescriptionExpanded;
  final bool isParticipating;
  final VoidCallback onParticipatePressed;
  final VoidCallback onToggleDescription;

  const _ChallengeDetailInfoCard({
    required this.challengeDetail,
    required this.isDescriptionExpanded,
    required this.isParticipating,
    required this.onParticipatePressed,
    required this.onToggleDescription,
  });

  String _formatDate(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final description = challengeDetail.description;
    final isLong = description.length > 80;

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
          // Title
          Text(challengeDetail.title, style: AppTextStyles.titLg),
          SizedBox(height: AppSpacing.md),

          // Participate button
          PrimaryButton(
            label: isParticipating ? '참여 중' : '참여하기',
            onPressed: isParticipating ? null : onParticipatePressed,
            disabled: isParticipating,
          ),
          SizedBox(height: AppSpacing.md),

          // Date range
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                '${_formatDate(challengeDetail.startDate)} ~ ${_formatDate(challengeDetail.endDate)}',
                style: AppTextStyles.txtXs.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),

          // Tags
          if (challengeDetail.tags.isNotEmpty) ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: challengeDetail.tags
                  .map((tag) => _TagChip(label: tag))
                  .toList(),
            ),
            SizedBox(height: AppSpacing.md),
          ],

          // Description + toggle
          Text(
            description,
            style: AppTextStyles.txtSm.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            maxLines: isDescriptionExpanded ? null : 3,
            overflow: isDescriptionExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
          ),
          if (isLong) ...[
            SizedBox(height: AppSpacing.xs),
            GestureDetector(
              onTap: onToggleDescription,
              child: Text(
                isDescriptionExpanded ? '접기' : '더보기',
                style: AppTextStyles.txtXs.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          SizedBox(height: AppSpacing.sm),
        ],
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
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary100,
        borderRadius: AppRadius.fullAll,
      ),
      child: Text(
        '#$label',
        style: AppTextStyles.txt2xs.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _ChallengeStatRow extends StatelessWidget {
  final int participantCount;
  final double totalDistanceKm;

  const _ChallengeStatRow({
    required this.participantCount,
    required this.totalDistanceKm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.people_outline,
              label: '참여자',
              value: '$participantCount명',
            ),
          ),
          Container(width: 1, height: 36, color: AppColors.divider),
          Expanded(
            child: _StatItem(
              icon: Icons.route_outlined,
              label: '누적 거리',
              value: '${totalDistanceKm.toStringAsFixed(0)}km',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTextStyles.titSm),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.txt2xs.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ChallengeTabBar extends StatelessWidget {
  final ValueChanged<int> onTabChanged;

  const _ChallengeTabBar({required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: TabBar(
        onTap: onTabChanged,
        labelStyle: AppTextStyles.titXs,
        unselectedLabelStyle: AppTextStyles.txtSm,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2,
        tabs: const [
          Tab(text: '정보'),
          Tab(text: '랭킹'),
        ],
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  final ChallengeDetailEntity challengeDetail;

  const _InfoTab({required this.challengeDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('챌린지 안내', style: AppTextStyles.titSm),
          SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.lgAll,
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  label: '목표 거리',
                  value:
                      '${challengeDetail.targetDistanceKm.toStringAsFixed(0)}km',
                ),
                SizedBox(height: AppSpacing.sm),
                const _InfoRow(label: '참여 방법', value: '앱에서 라이딩 기록 후 자동 집계'),
                SizedBox(height: AppSpacing.sm),
                _InfoRow(
                  label: '기간',
                  value:
                      '${_formatDate(challengeDetail.startDate)} ~ ${_formatDate(challengeDetail.endDate)}',
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Text('유의사항', style: AppTextStyles.titSm),
          SizedBox(height: AppSpacing.sm),
          Text(
            '· GPS 기반 라이딩 기록만 인정됩니다.\n'
            '· 챌린지 기간 내 누적 거리를 기준으로 집계됩니다.\n'
            '· 부정 행위 적발 시 랭킹에서 제외됩니다.',
            style: AppTextStyles.txtXs.copyWith(
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
        ),
        Expanded(child: Text(value, style: AppTextStyles.txtXs)),
      ],
    );
  }
}

// Ranking Tab

class _RankingTab extends StatelessWidget {
  final List<ChallengeRankingEntity> rankingList;

  const _RankingTab({required this.rankingList});

  @override
  Widget build(BuildContext context) {
    if (rankingList.isEmpty) {
      return Center(
        child: Text(
          '아직 랭킹 정보가 없습니다.',
          style: AppTextStyles.txtMd.copyWith(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: rankingList.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: AppColors.divider),
      itemBuilder: (context, index) {
        return ChallengeRankingListItem(entity: rankingList[index]);
      },
    );
  }
}

class ChallengeRankingListItem extends StatelessWidget {
  final ChallengeRankingEntity entity;

  const ChallengeRankingListItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final isTopThree = entity.rank <= 3;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 32,
            child: isTopThree
                ? Center(child: _RankBadge(rank: entity.rank))
                : Center(
                    child: Text(
                      '${entity.rank}',
                      style: AppTextStyles.titXs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.gray100,
              shape: BoxShape.circle,
            ),
            child: entity.profileImageUrl != null
                ? ClipOval(
                    child: Image.network(
                      entity.profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person_rounded,
                        color: AppColors.gray400,
                        size: 24,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.person_rounded,
                    color: AppColors.gray400,
                    size: 24,
                  ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Nickname
          Expanded(child: Text(entity.nickname, style: AppTextStyles.titXs)),

          // Distance
          Text(
            '${entity.distanceKm.toStringAsFixed(1)}km',
            style: AppTextStyles.txtSm.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  Color get _color {
    return switch (rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFC0C0C0),
      3 => const Color(0xFFCD7F32),
      _ => AppColors.gray300,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$rank',
          style: AppTextStyles.tit2xs.copyWith(color: AppColors.surface),
        ),
      ),
    );
  }
}

class ActivityChallengeDetailPageConnected extends StatefulWidget {
  final String challengeId;

  const ActivityChallengeDetailPageConnected({
    super.key,
    required this.challengeId,
  });

  @override
  State<ActivityChallengeDetailPageConnected> createState() =>
      _ActivityChallengeDetailPageConnectedState();
}

class _ActivityChallengeDetailPageConnectedState
    extends State<ActivityChallengeDetailPageConnected> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivityChallengeDetailViewModel>().loadChallengeDetail(
        widget.challengeId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityChallengeDetailViewModel>(
      builder: (context, vm, _) {
        return ActivityChallengeDetailPage(
          challengeDetail: vm.challengeDetail,
          isLoading: vm.isLoading,
          errorMessage: vm.errorMessage,
          isDescriptionExpanded: vm.isDescriptionExpanded,
          selectedTabIndex: vm.selectedTabIndex,
          isParticipating: vm.isParticipating,
          rankingList: vm.rankingList,
          onBackPressed: () => Navigator.of(context).pop(),
          onSharePressed: () {
            // TODO: 공유 기능 구현
          },
          onParticipatePressed: () =>
              vm.onParticipatePressed(widget.challengeId),
          onToggleDescription: vm.onToggleDescription,
          onTabChanged: vm.onTabChanged,
        );
      },
    );
  }
}
