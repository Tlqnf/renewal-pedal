import 'package:flutter/material.dart';
import 'package:pedal/features/feed/viewmodels/feed_viewmodel.dart';
import 'package:pedal/features/feed/widgets/feed_card.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/components/appbars/pedal_appbar.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/core/routes/app_routes.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedViewModel>().loadFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FeedViewModel>();

    return Scaffold(
      appBar: PedalAppBar(
        title: '피드',
        onNotificationTap: () {
          context.push(AppRoutes.notificationList);
        },
      ),
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.feeds.isEmpty
            ? const Center(
                child: Text('아직 피드가 없어요', style: AppTextStyles.txtMd),
              )
            : RefreshIndicator(
                onRefresh: viewModel.refreshFeeds,
                child: ListView.separated(
                  itemCount: viewModel.feeds.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 48),
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
                      onCardTap: () {},
                      onLikeTap: () => viewModel.toggleLike(feed.id),
                      onBookmarkTap: () => viewModel.toggleBookmark(feed.id),
                      onSaveRoute: () => debugPrint('경로 저장: ${feed.id}'),
                      onReportFeed: () {},
                    );
                  },
                ),
              ),
      ),
    );
  }
}
