import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/indicators/status_indicator_item.dart';
import 'package:pedal/core/config/app_config.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/features/feed/widgets/comments_sheet.dart';
import 'package:pedal/core/utils/helpers/date_formatter.dart';

class FeedCard extends StatefulWidget {
  final String postId;
  final String username;
  final String userAvatarUrl;
  final List<String> imageUrls;
  final String? routeDistance;
  final String title;
  final String description;
  final String date;
  final int likes;
  final int comments;
  final bool isBookmarked;
  final bool isAuthor;
  final VoidCallback? onCardTap;
  final VoidCallback? onLikeTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onSaveRoute;
  final VoidCallback? onReportFeed;

  const FeedCard({
    super.key,
    required this.postId,
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrls,
    this.routeDistance,
    required this.title,
    required this.description,
    required this.date,
    required this.likes,
    required this.comments,
    this.isBookmarked = false,
    this.isAuthor = false,
    this.onCardTap,
    this.onLikeTap,
    this.onBookmarkTap,
    this.onSaveRoute,
    this.onReportFeed,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool _isExpanded = false;
  int _currentPage = 0;
  late int _likes;
  late bool _isLiked;
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _likes = widget.likes;
    _isLiked = false;
    _isBookmarked = widget.isBookmarked;
  }

  Widget _buildImage(String url) {
    final fallback = Container(
      decoration: BoxDecoration(color: AppColors.border),
      child: Icon(Icons.map, color: AppColors.textSecondary, size: 48),
    );
    final fullUrl = url.startsWith('/')
        ? '${AppConfig.baseUrl.replaceAll(RegExp(r'/$'), '')}$url'
        : url;
    if (fullUrl.startsWith('http://') || fullUrl.startsWith('https://')) {
      return Image.network(
        fullUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
        errorBuilder: (_, _, _) => fallback,
      );
    }
    return Image.asset(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
      errorBuilder: (_, _, _) => fallback,
    );
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes = _isLiked ? _likes + 1 : _likes - 1;
    });
    widget.onLikeTap?.call();
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    widget.onBookmarkTap?.call();
  }

  void _showCommentsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) =>
          CommentsSheet(postId: widget.postId, commentCount: widget.comments),
    );
  }

  void _showMenuBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.25,
        maxChildSize: 0.3,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 핸들 — scrollController에 연결해야 드래그 인식
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.isAuthor) ...[
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  title: Text(
                    '피드 수정',
                    style: AppTextStyles.txtMd.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onReportFeed?.call();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  title: Text(
                    '피드 삭제',
                    style: AppTextStyles.txtMd.copyWith(color: AppColors.error),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onReportFeed?.call();
                  },
                ),
              ],
              ListTile(
                leading: Icon(
                  Icons.route,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                title: Text('경로 저장', style: AppTextStyles.txtMd),
                onTap: () {
                  Navigator.pop(context);
                  widget.onSaveRoute?.call();
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: AppColors.error, size: 24),
                title: Text(
                  '피드 신고',
                  style: AppTextStyles.txtMd.copyWith(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.onReportFeed?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardTap,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 프로필 헤더
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: widget.userAvatarUrl.isNotEmpty
                            ? Image.network(
                                widget.userAvatarUrl.startsWith('/')
                                    ? '${AppConfig.baseUrl.replaceAll(RegExp(r'/$'), '')}${widget.userAvatarUrl}'
                                    : widget.userAvatarUrl,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Image.asset(
                                  AppConstants.profile,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                AppConstants.profile,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Text(widget.username, style: AppTextStyles.titSmMedium),
                    ],
                  ),
                  GestureDetector(
                    onTap: _showMenuBottomSheet,
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.md),

            // 2. 이미지 캐러셀
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildImage(widget.imageUrls[index]);
                },
              ),
            ),

            // 페이지 인디케이터
            if (widget.imageUrls.length > 1)
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imageUrls.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: StatusIndicatorItem(
                        status: _currentPage == index
                            ? StatusIndicatorType.active
                            : StatusIndicatorType.inactive,
                        size: 6,
                      ),
                    ),
                  ),
                ),
              ),

            // 3. 상호작용 아이콘
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Row(
                          children: [
                            Icon(
                              _isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              color: _isLiked
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fill: _isLiked ? 1 : 0,
                              size: 24,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(_likes.toString(), style: AppTextStyles.txtSm),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSpacing.lg),
                      GestureDetector(
                        onTap: _showCommentsBottomSheet,
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: AppColors.textSecondary,
                              size: 24,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              widget.comments.toString(),
                              style: AppTextStyles.txtSm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _toggleBookmark,
                    child: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: _isBookmarked
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fill: _isBookmarked ? 1 : 0,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // 4. 내용 섹션
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: 해시태그 — Wrap + '#태그' chip 형태로 description 아래 표시
                  // 예: #한강 #출근라이딩 #힐클라이밍

                  // 제목
                  Text(widget.title, style: AppTextStyles.titSmBold),
                  SizedBox(height: 8),

                  // 내용 + 더보기/접기
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.description,
                        style: AppTextStyles.txtSm,
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? '접기' : '더보기',
                          style: AppTextStyles.txtSm.copyWith(
                            color: AppColors.textThird,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.md),

                  // 날짜
                  Text(
                    DateFormatter.timeAgo(widget.date),
                    style: AppTextStyles.txtSm.copyWith(
                      color: AppColors.textThird,
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
