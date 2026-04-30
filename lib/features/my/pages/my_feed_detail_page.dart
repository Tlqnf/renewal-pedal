import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/features/my/viewmodels/my_feed_detail_view_model.dart';

class MyFeedDetailPage extends StatefulWidget {
  final String feedId;

  const MyFeedDetailPage({super.key, required this.feedId});

  @override
  State<MyFeedDetailPage> createState() => _MyFeedDetailPageState();
}

class _MyFeedDetailPageState extends State<MyFeedDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyFeedDetailViewModel>().loadFeedDetail(
        feedId: widget.feedId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyFeedDetailViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(
        title: '게시물',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.errorMessage != null
          ? Center(
              child: Text(
                vm.errorMessage!,
                style: AppTextStyles.txtSm.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeedAuthorRow(
                    profileImageUrl: vm.authorProfileImageUrl,
                    nickname: vm.authorNickname,
                    onMoreTap: vm.onMoreTap,
                  ),
                  _FeedImageView(imageUrl: vm.feedImageUrl),
                  _FeedActionRow(
                    likeCount: vm.likeCount,
                    commentCount: vm.commentCount,
                    isLiked: vm.isLiked,
                    isBookmarked: vm.isBookmarked,
                    onLikeTap: vm.onLikeTap,
                    onCommentTap: vm.onCommentTap,
                    onBookmarkTap: vm.onBookmarkTap,
                  ),
                  if (vm.hashtags.isNotEmpty)
                    _FeedHashtagRow(hashtags: vm.hashtags),
                  _ExpandableContent(
                    title: vm.title,
                    content: vm.content,
                    isExpanded: vm.isContentExpanded,
                    onToggle: vm.onExpandContent,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.xs,
                      AppSpacing.md,
                      AppSpacing.lg,
                    ),
                    child: Text(
                      _formatDate(vm.createdAt),
                      style: AppTextStyles.txtXs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

class _FeedAuthorRow extends StatelessWidget {
  final String? profileImageUrl;
  final String nickname;
  final VoidCallback onMoreTap;

  const _FeedAuthorRow({
    required this.profileImageUrl,
    required this.nickname,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.gray200,
            backgroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl!)
                : null,
            child: profileImageUrl == null
                ? Icon(Icons.person, color: AppColors.gray500, size: 20)
                : null,
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(nickname, style: AppTextStyles.titXs)),
          IconButton(
            onPressed: onMoreTap,
            icon: Icon(Icons.more_vert, color: AppColors.textPrimary, size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _FeedImageView extends StatelessWidget {
  final String imageUrl;

  const _FeedImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Image.network(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.gray200,
          child: Icon(
            Icons.image_not_supported,
            color: AppColors.gray400,
            size: 48,
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: AppColors.gray200,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class _FeedActionRow extends StatelessWidget {
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isBookmarked;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onBookmarkTap;

  const _FeedActionRow({
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.isBookmarked,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onLikeTap,
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 20,
                  color: isLiked ? AppColors.primary : AppColors.textSecondary,
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  '$likeCount',
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: onCommentTap,
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  '$commentCount',
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onBookmarkTap,
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              size: 22,
              color: isBookmarked ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedHashtagRow extends StatelessWidget {
  final List<String> hashtags;

  const _FeedHashtagRow({required this.hashtags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        0,
      ),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: 0,
        children: hashtags
            .map(
              (tag) => Text(
                '#$tag',
                style: AppTextStyles.txtXs.copyWith(color: AppColors.primary),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ExpandableContent extends StatelessWidget {
  final String title;
  final String content;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _ExpandableContent({
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.titSmMedium),
          SizedBox(height: AppSpacing.xs),
          Text(
            content,
            style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                isExpanded ? '접기' : '더보기',
                style: AppTextStyles.txtXs.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
