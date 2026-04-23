import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/my/entities/feed_entity.dart';
import 'package:pedal/features/my/viewmodels/my_feed_list_view_model.dart';
import 'package:pedal/features/my/widgets/feed_grid_item.dart';
import 'package:pedal/features/my/widgets/section_header.dart';

// ─── Pure View (props-only, no ViewModel) ────────────────────────────────────

class MyFeedListPage extends StatelessWidget {
  // 상태 props
  final List<FeedEntity> feeds;
  final int totalCount;
  final String userName;
  final bool isLoading;
  final String? errorMessage;

  // 액션 props
  final VoidCallback onBack;
  final void Function(String feedId) onFeedTap;
  final VoidCallback onMoreTap;

  const MyFeedListPage({
    super.key,
    required this.feeds,
    required this.totalCount,
    required this.userName,
    required this.isLoading,
    required this.errorMessage,
    required this.onBack,
    required this.onFeedTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BackAppBar(
        title: '게시물',
        onBackPressed: onBack,
        actions: [
          Text(
            '$totalCount',
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!, style: AppTextStyles.txtSm));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SectionHeader(
            title: '$userName님의 게시물이에요',
            count: totalCount,
            onMoreTap: onMoreTap,
          ),
        ),
        if (feeds.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                '게시물이 없어요',
                style: AppTextStyles.txtSm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final feed = feeds[index];
                return FeedGridItem(
                  feed: feed,
                  onTap: () => onFeedTap(feed.id),
                );
              }, childCount: feeds.length),
            ),
          ),
      ],
    );
  }
}

// ─── Connected (ViewModel 연결) ───────────────────────────────────────────────

class MyFeedListPageConnected extends StatefulWidget {
  final String userId;
  final String userName;

  const MyFeedListPageConnected({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<MyFeedListPageConnected> createState() =>
      _MyFeedListPageConnectedState();
}

class _MyFeedListPageConnectedState extends State<MyFeedListPageConnected> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyFeedListViewModel>().loadFeedList(
        userId: widget.userId,
        userName: widget.userName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyFeedListViewModel>(
      builder: (context, vm, _) {
        return MyFeedListPage(
          feeds: vm.feeds,
          totalCount: vm.totalCount,
          userName: vm.userName,
          isLoading: vm.isLoading,
          errorMessage: vm.errorMessage,
          onBack: () => Navigator.of(context).pop(),
          onFeedTap: (feedId) {
            // TODO: 피드 상세 라우팅
          },
          onMoreTap: () {
            // TODO: 더보기 라우팅
          },
        );
      },
    );
  }
}
