import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';

class RouteCard extends StatelessWidget {
  final SavedRouteEntity route;
  final VoidCallback onTap;

  const RouteCard({super.key, required this.route, required this.onTap});

  String _formatDuration(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final hStr = h.toString().padLeft(2, '0');
    final mStr = m.toString().padLeft(2, '0');
    return '$hStr:$mStr:00';
  }

  String _formatDateTime(DateTime d) {
    final year = d.year;
    final month = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final hour = d.hour;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'AM' : 'PM';
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$year.$month.$day $period ${hour12.toString().padLeft(2, '0')}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                bottomLeft: Radius.circular(AppRadius.lg),
              ),
              child: route.mapThumbnailUrl != null
                  ? Image.network(
                      route.mapThumbnailUrl!,
                      width: 110,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _placeholderThumbnail(),
                    )
                  : _placeholderThumbnail(),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.name,
                      style: AppTextStyles.titSm,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Text(
                          '${route.distanceKm.toStringAsFixed(2)} km',
                          style: AppTextStyles.txtMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          _formatDuration(route.durationMinutes),
                          style: AppTextStyles.txtSm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      _formatDateTime(route.savedAt),
                      style: AppTextStyles.txtXs.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Widget _placeholderThumbnail() {
    return Container(
      width: 110,
      height: 90,
      color: AppColors.gray100,
      child: const Center(
        child: Icon(Icons.map_outlined, color: AppColors.gray400, size: 32),
      ),
    );
  }
}
