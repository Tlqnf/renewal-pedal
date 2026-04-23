import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';

class SavedRouteListItem extends StatelessWidget {
  final SavedRouteEntity route;
  final VoidCallback onTap;

  const SavedRouteListItem({
    super.key,
    required this.route,
    required this.onTap,
  });

  String _formatDateTime(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final h = route.durationMinutes ~/ 60;
    final m = route.durationMinutes % 60;
    final duration = h > 0 ? '${h}h ${m}m' : '${m}m';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: AppRadius.smAll,
              child: Container(
                width: 64,
                height: 64,
                color: AppColors.gray100,
                child: const Center(
                  child: Icon(
                    Icons.map_outlined,
                    color: AppColors.gray400,
                    size: 28,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(route.name, style: AppTextStyles.titXs),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '${route.distanceKm.toStringAsFixed(1)}km  ·  $duration',
                    style: AppTextStyles.txtXs.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    _formatDateTime(route.savedAt),
                    style: AppTextStyles.txt2xs.copyWith(
                      color: AppColors.textSecondary,
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
