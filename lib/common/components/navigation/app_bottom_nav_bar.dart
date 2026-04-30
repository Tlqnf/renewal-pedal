import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';

const double _navBarHeight = 64;

enum BottomNavItem {
  home('홈', Icons.home_rounded),
  feed('피드', Icons.article_rounded),
  map('', Icons.map_rounded),
  activity('크루', Icons.directions_bike_rounded),
  stats('통계', Icons.bar_chart_rounded);

  const BottomNavItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _navBarHeight + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 배경 + 그림자
          Positioned.fill(child: CustomPaint(painter: _NotchPainter())),
          // Nav items
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _navBarHeight,
            child: Row(
              children: List.generate(BottomNavItem.values.length, (index) {
                final item = BottomNavItem.values[index];
                final isCenter = index == BottomNavItem.map.index;
                final isActive = currentIndex == index;

                if (isCenter) return const Expanded(child: SizedBox.shrink());

                return Expanded(
                  child: _NavItem(
                    item: item,
                    isActive: isActive,
                    onTap: () => onTap(index),
                  ),
                );
              }),
            ),
          ),
          // Center FAB
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: _MapFab(
                isActive: currentIndex == BottomNavItem.map.index,
                onTap: () => onTap(BottomNavItem.map.index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotchPainter extends CustomPainter {
  static const double _notchHalfWidth = 28.0;
  static const double _notchDepth = 22.0;
  static const double _edgeCurve = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final x1 = cx - _notchHalfWidth;
    final x2 = cx + _notchHalfWidth;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x1 - _edgeCurve, 0)
      ..cubicTo(x1 - _edgeCurve / 2, 0, x1, -_notchDepth, cx, -_notchDepth)
      ..cubicTo(x2, -_notchDepth, x2 + _edgeCurve / 2, 0, x2 + _edgeCurve, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // 그림자: y offset -1 (상단에만 보이도록)
    canvas.drawShadow(
      path.shift(const Offset(0, -1)),
      AppColors.gray900.withValues(alpha: 1),
      2,
      false,
    );
    canvas.drawPath(path, Paint()..color = AppColors.surface);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NavItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textDisabled;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, color: color, size: 24),
          SizedBox(height: AppSpacing.xs),
          Text(item.label, style: AppTextStyles.titXs.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _MapFab extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _MapFab({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.gray400.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: const Icon(
          Icons.map_rounded,
          color: AppColors.surface,
          size: 28,
        ),
      ),
    );
  }
}
