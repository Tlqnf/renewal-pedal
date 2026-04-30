import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pedal/core/routes/app_routes.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/features/my/viewmodels/my_feed_list_view_model.dart';
import 'package:pedal/features/my/widgets/feed_grid_item.dart';
import 'package:pedal/common/components/lists/section_header.dart';

class MyFeedListPage extends StatefulWidget {
  final String userId;
  final String userName;

  const MyFeedListPage({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<MyFeedListPage> createState() => _MyFeedListPageState();
}

class _MyFeedListPageState extends State<MyFeedListPage> {
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
    final vm = context.watch<MyFeedListViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(
        title: '게시물',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          Text(
            '${vm.totalCount}',
            style: AppTextStyles.titSmMedium.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(vm),
    );
  }

  Widget _buildBody(MyFeedListViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(child: Text(vm.errorMessage!, style: AppTextStyles.txtSm));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SectionHeader(
            title: '${vm.userName}님의 게시물이에요',
            count: vm.totalCount,
            onMoreTap: () {},
          ),
        ),
        if (vm.feeds.isEmpty)
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
                final feed = vm.feeds[index];
                return FeedGridItem(
                  feed: feed,
                  onTap: () =>
                      context.push(AppRoutes.myFeedDetailPath(feed.id)),
                );
              }, childCount: vm.feeds.length),
            ),
          ),
      ],
    );
  }
}
