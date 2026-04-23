import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/ranking/entities/ranking_entity.dart';

class RankingPodiumSection extends StatelessWidget {
  final List<RankingEntity> top3;

  const RankingPodiumSection({super.key, required this.top3});

  @override
  Widget build(BuildContext context) {
    if (top3.isEmpty) return const SizedBox.shrink();

    final first = top3.isNotEmpty ? top3[0] : null;
    final second = top3.length > 1 ? top3[1] : null;
    final third = top3.length > 2 ? top3[2] : null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (second != null)
            _PodiumItem(entity: second, size: 60, showCrown: false),
          SizedBox(width: AppSpacing.lg),
          if (first != null)
            _PodiumItem(entity: first, size: 72, showCrown: true),
          SizedBox(width: AppSpacing.lg),
          if (third != null)
            _PodiumItem(entity: third, size: 60, showCrown: false),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final RankingEntity entity;
  final double size;
  final bool showCrown;

  const _PodiumItem({
    required this.entity,
    required this.size,
    required this.showCrown,
  });

  Color get _badgeColor {
    return switch (entity.rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFC0C0C0),
      3 => const Color(0xFFCD7F32),
      _ => AppColors.gray400,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCrown)
          const Icon(
            Icons.emoji_events_rounded,
            color: Color(0xFFFFD700),
            size: 24,
          )
        else
          const SizedBox(height: 24),
        SizedBox(height: AppSpacing.xs),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                shape: BoxShape.circle,
                border: Border.all(color: _badgeColor, width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.gray400,
                  size: 32,
                ),
              ),
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: _badgeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${entity.rank}',
                    style: AppTextStyles.tit2xs.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        Text(entity.nickname, style: AppTextStyles.titXs),
        Text(
          '${entity.value.toStringAsFixed(entity.unit == 'km' ? 1 : 0)}${entity.unit}',
          style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
