import 'package:flutter/material.dart';
import 'package:pedal/features/feed/viewmodels/feed_viewmodel.dart';
import 'package:pedal/features/feed/widgets/feed_card.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/components/appbars/pedal_appbar.dart';
import 'package:pedal/core/routes/app_routes.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<FeedViewModel>()..loadFeeds(),
      child: const _FeedPageContent(),
    );
  }
}

class _FeedPageContent extends StatelessWidget {
  const _FeedPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FeedViewModel>();

    return Scaffold(
      appBar: PedalAppBar(
        title: '피드',
        onSearchTap: () {
          // context.push(RouteNames.search);
          // TODO: 검색 페이지 필요
        },
        onNotificationTap: () {
          context.push(AppRoutes.notificationList);
        },
      ),
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.feeds.isEmpty
            ? const Center(
                child: Text('아직 피드가 없어요', style: TextStyle(fontSize: 16)),
              )
            : RefreshIndicator(
                onRefresh: viewModel.refreshFeeds,
                child: ListView.separated(
                  itemCount: viewModel.feeds.length,
                  separatorBuilder: (_, _) => SizedBox(height: 48),
                  itemBuilder: (context, index) {
                    final feed = viewModel.feeds[index];
                    return FeedCard(
                      postId: feed.id,
                      isAuthor: viewModel.isAuthor(feed.userId),
                      username: feed.username,
                      userAvatarUrl: feed.userAvatarUrl,
                      imageUrls: feed.imageUrls,
                      routeDistance: feed.routeDistance,
                      title: feed.title,
                      description: feed.description,
                      date: feed.date,
                      likes: feed.likes,
                      comments: feed.comments,
                      isBookmarked: feed.isBookmarked,
                      onCardTap: () {
                        // TODO: Feed Detail Route 설정
                        // context.push('${AppRoutes.feedDetail}?id=${feed.id}');
                      },
                      onLikeTap: () {
                        viewModel.toggleLike(feed.id);
                      },
                      onBookmarkTap: () {
                        viewModel.toggleBookmark(feed.id);
                      },
                      onSaveRoute: () {
                        debugPrint('경로 저장: ${feed.id}');
                        // TODO: 경로 저장 기능
                      },
                      onReportFeed: () {
                        // TODO: 상세 리포트 이동
                        // context.push(
                        //   AppRoutes.report,
                        //   extra: {'targetType': 'feed', 'targetId': feed.id},
                        // );
                      },
                    );
                  },
                ),
              ),
      ),
      // TODO: FAB 공통 추가 필요.
      // floatingActionButton: FloatingButton(
      //   menuItems: [
      //     FloatingMenuItemData(
      //       label: '새 피드 작성',
      //       icon: Icons.article,
      //       onPressed: () {
      //         // context.push(RouteNames.createFeed);
      //       },
      //     ),
      //     FloatingMenuItemData(
      //       label: '라이딩 시작',
      //       icon: Icons.directions_bike,
      //       onPressed: () {
      //         // context.push(RouteNames.record);
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
