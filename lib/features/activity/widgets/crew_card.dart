import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class CrewCard extends StatelessWidget {
  final CrewEntity crew;
  final VoidCallback onTap;

  const CrewCard({super.key, required this.crew, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 썸네일 이미지
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: AppRadius.lgAll,
              child: crew.imageUrl != null
                  ? Image.network(
                      crew.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _PlaceholderImage(),
                    )
                  : _PlaceholderImage(),
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          // 크루명
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Text(
              crew.name,
              style: AppTextStyles.titXs,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          // 위치
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 2),
                Text(
                  crew.location,
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          // 멤버수
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 2),
                Text(
                  _formatNumber(crew.memberCount),
                  style: AppTextStyles.txtXs.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray100,
      child: Center(
        child: Icon(
          Icons.directions_bike_rounded,
          color: AppColors.gray300,
          size: 32,
        ),
      ),
    );
  }
}
