import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';

class RecordingControls extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onPauseToggle;
  final VoidCallback onStop;

  const RecordingControls({
    super.key,
    required this.isPaused,
    required this.onPauseToggle,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onPauseToggle,
            child: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: AppColors.textSecondary,
              size: 36,
              fill: 1,
            ),
          ),
          SizedBox(width: 24),
          GestureDetector(
            onTap: onStop,
            child: Icon(
              Icons.stop,
              color: AppColors.textSecondary,
              size: 36,
              fill: 1,
            ),
          ),
        ],
      ),
    );
  }
}
