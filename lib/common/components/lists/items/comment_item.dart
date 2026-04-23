import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/core/utils/helpers/date_formatter.dart';
import 'package:pedal/domain/feed/entities/comment_entity.dart';

class CommentItem extends StatelessWidget {
  final String authorImage;
  final String authorName;
  final String content;
  final String createdAt;
  final int likeCount;
  final int replyCount;
  final List<String>? mentions;
  final VoidCallback? onLike;
  final VoidCallback? onReply;

  // 대댓글 관련
  final bool isExpanded;
  final bool isLoadingReplies;
  final List<CommentEntity> replies;
  final VoidCallback? onToggleReplies;

  const CommentItem({
    super.key,
    required this.authorImage,
    required this.authorName,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.replyCount,
    this.mentions,
    this.onLike,
    this.onReply,
    this.isExpanded = false,
    this.isLoadingReplies = false,
    this.replies = const [],
    this.onToggleReplies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(imageUrl: authorImage, size: 48),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                authorName,
                                style: AppTextStyles.titSm,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                DateFormatter.timeAgo(createdAt),
                                style: AppTextStyles.txtSm.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.md),
                    // Comment Content
                    Text(
                      content,
                      style: AppTextStyles.txtSm,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.lg),
                // Actions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: onLike,
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Text(
                            likeCount.toString().replaceAllMapped(
                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                              (match) => ',',
                            ),
                            style: AppTextStyles.txtSm,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    GestureDetector(
                      onTap: onReply,
                      child: Text('댓글 달기', style: AppTextStyles.txtSm),
                    ),
                  ],
                ),
                // 대댓글 토글 버튼
                if (replyCount > 0)
                  Padding(
                    padding: EdgeInsets.only(top: AppSpacing.md),
                    child: GestureDetector(
                      onTap: onToggleReplies,
                      child: Row(
                        children: [
                          Icon(
                            isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Text(
                            isExpanded ? '대댓글 접기' : '대댓글 $replyCount개 보기',
                            style: AppTextStyles.txtSm.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // 대댓글 목록
                if (isExpanded) ...[
                  SizedBox(height: AppSpacing.md),
                  if (isLoadingReplies)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    ...replies.map((reply) => _ReplyItem(reply: reply)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const _Avatar({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.person, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _ReplyItem extends StatelessWidget {
  final CommentEntity reply;

  const _ReplyItem({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, top: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(imageUrl: reply.authorAvatarUrl, size: 32),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(reply.authorName, style: AppTextStyles.txtSm),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      DateFormatter.timeAgo(reply.createdAt),
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs),
                Text(reply.content, style: AppTextStyles.txtSm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
