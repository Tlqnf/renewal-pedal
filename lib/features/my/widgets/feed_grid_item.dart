import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/feed_entity.dart';

class FeedGridItem extends StatelessWidget {
  final FeedEntity feed;
  final VoidCallback onTap;

  const FeedGridItem({super.key, required this.feed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: AppRadius.smAll,
            child: Image.network(
              feed.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.gray100,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.gray300,
                  size: 28,
                ),
              ),
            ),
          ),
          if (feed.hasMultipleImages)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(
                Icons.collections,
                color: AppColors.gray0,
                size: 16,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
        ],
      ),
    );
  }
}
