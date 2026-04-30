import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';

enum StatusIndicatorType { active, inactive }

class StatusIndicatorItem extends StatelessWidget {
  final StatusIndicatorType status;
  final double size;

  const StatusIndicatorItem({
    super.key,
    required this.status,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == StatusIndicatorType.active;
    final color = isActive ? AppColors.primary400 : AppColors.border;

    if (isActive) {
      // Active: Pill shape (타원형 캡슐)
      return Container(
        width: size * 2,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppRadius.fullAll,
        ),
      );
    } else {
      // Inactive: Circle (원형)
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }
  }
}
