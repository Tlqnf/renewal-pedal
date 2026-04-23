import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/components/lists/items/comment_item.dart';
import 'package:pedal/features/feed/viewmodels/feed_viewmodel.dart';

class CommentsSheet extends StatefulWidget {
  final String postId;
  final int commentCount;
  final String userAvatarUrl;
  final String username;

  const CommentsSheet({
    super.key,
    required this.postId,
    required this.commentCount,
    required this.userAvatarUrl,
    required this.username,
  });

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // null이면 댓글 모드, 값이 있으면 해당 commentId에 대댓글 모드
  String? _replyTargetCommentId;
  String? _replyTargetAuthorName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedViewModel>().loadComments(widget.postId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startReply(String commentId, String authorName) {
    setState(() {
      _replyTargetCommentId = commentId;
      _replyTargetAuthorName = authorName;
    });
    _focusNode.requestFocus();
  }

  void _cancelReply() {
    setState(() {
      _replyTargetCommentId = null;
      _replyTargetAuthorName = null;
    });
    _focusNode.unfocus();
  }

  void _submit(FeedViewModel vm) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (_replyTargetCommentId != null) {
      vm.createReply(widget.postId, _replyTargetCommentId!, text);
    } else {
      vm.createComment(widget.postId, text);
    }

    _controller.clear();
    _cancelReply();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 0),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // 핸들
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // 제목
            Consumer<FeedViewModel>(
              builder: (context, vm, _) => Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  '댓글 ${vm.comments.length}개',
                  style: AppTextStyles.titMd,
                ),
              ),
            ),
            // 댓글 목록
            Expanded(
              child: Consumer<FeedViewModel>(
                builder: (context, vm, _) {
                  if (vm.isLoadingComments) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (vm.comments.isEmpty) {
                    return Center(
                      child: Text(
                        '첫 번째 댓글을 남겨보세요!',
                        style: AppTextStyles.txtSm,
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: vm.comments.length,
                    itemBuilder: (context, index) {
                      final comment = vm.comments[index];
                      return CommentItem(
                        authorImage: comment.authorAvatarUrl,
                        authorName: comment.authorName,
                        content: comment.content,
                        createdAt: comment.createdAt,
                        likeCount: comment.likeCount,
                        replyCount: comment.replyCount,
                        onLike: () => vm.toggleCommentLike(comment.id),
                        onReply: () =>
                            _startReply(comment.id, comment.authorName),
                        isExpanded: vm.isRepliesExpanded(comment.id),
                        isLoadingReplies: vm.isLoadingRepliesFor(comment.id),
                        replies: vm.getRepliesFor(comment.id),
                        onToggleReplies: () =>
                            vm.toggleRepliesExpanded(comment.id, widget.postId),
                      );
                    },
                  );
                },
              ),
            ),
            // 대댓글 모드 배너
            if (_replyTargetCommentId != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: AppSpacing.xs,
                ),
                color: AppColors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '@$_replyTargetAuthorName 에게 대댓글 작성 중',
                        style: AppTextStyles.txtSm.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _cancelReply,
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            // 입력창
            SafeArea(
              top: false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 1),
                  ),
                ),
                child: Consumer<FeedViewModel>(
                  builder: (context, vm, _) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      GestureDetector(
                        onTap: () => _submit(vm),
                        child: Icon(
                          Icons.send,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                    ],
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
