import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/ranking/entities/ranking_entity.dart';

class RankingListItem extends StatelessWidget {
  final RankingEntity entity;
  final VoidCallback onTap;

  const RankingListItem({super.key, required this.entity, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
              width: 28,
              child: Text(
                '${entity.rank}',
                style: AppTextStyles.titSmMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.gray200,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.gray500,
                  size: 22,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(entity.nickname, style: AppTextStyles.titXs)),
            Text(
              '${entity.value.toStringAsFixed(entity.unit == 'km' ? 1 : 0)}${entity.unit}',
              style: AppTextStyles.txtSm.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
