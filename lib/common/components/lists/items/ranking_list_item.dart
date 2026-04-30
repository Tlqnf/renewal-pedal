import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class RankingListItem extends StatelessWidget {
  final int rank;
  final String? profileImageUrl;
  final String nickname;
  final String value;
  final bool showRankBadge;
  final VoidCallback? onTap;

  const RankingListItem({
    super.key,
    required this.rank,
    this.profileImageUrl,
    required this.nickname,
    required this.value,
    this.showRankBadge = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTopThree = showRankBadge && rank <= 3;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: isTopThree
                  ? Center(child: _RankBadge(rank: rank))
                  : Center(
                      child: Text(
                        '$rank',
                        style: AppTextStyles.titXs.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            SizedBox(width: AppSpacing.sm),
            _Avatar(imageUrl: profileImageUrl),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(nickname, style: AppTextStyles.titXs)),
            Text(
              value,
              style: AppTextStyles.txtSm.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;

  const _Avatar({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: AppColors.gray200,
        shape: BoxShape.circle,
      ),
      child: imageUrl != null
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.person_rounded,
                  color: AppColors.gray500,
                  size: 24,
                ),
              ),
            )
          : const Icon(
              Icons.person_rounded,
              color: AppColors.gray500,
              size: 24,
            ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  Color get _color => switch (rank) {
    1 => const Color(0xFFFFD700),
    2 => const Color(0xFFC0C0C0),
    3 => const Color(0xFFCD7F32),
    _ => AppColors.gray400,
  };

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
