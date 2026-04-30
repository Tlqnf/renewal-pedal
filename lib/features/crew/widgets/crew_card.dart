import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/core/constants/constants.dart';
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
            aspectRatio: 3 / 2,
            child: ClipRRect(
              borderRadius: AppRadius.lgAll,
              child: crew.imageUrl != null
                  ? Image.network(crew.imageUrl!, fit: BoxFit.cover)
                  : Image.asset(AppConstants.crewCover, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 12),
          // 크루명
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              crew.name,
              style: AppTextStyles.titSmMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                // 위치
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textThird,
                    ),
                    SizedBox(width: 2),
                    Text(
                      crew.location,
                      style: AppTextStyles.txtXs.copyWith(
                        color: AppColors.textThird,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4),
                // 멤버수
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: AppColors.textThird,
                    ),
                    SizedBox(width: 2),
                    Text(
                      _formatNumber(crew.memberCount),
                      style: AppTextStyles.txtXs.copyWith(
                        color: AppColors.textThird,
                      ),
                    ),
                  ],
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
