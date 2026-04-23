import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

enum BottomNavItem {
  home('홈', Icons.home_rounded),
  feed('피드', Icons.article_rounded),
  map('', Icons.map_rounded),
  activity('활동', Icons.directions_bike_rounded),
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
      height: 64 + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Notch background with shadow (전체 높이 채움)
          Positioned.fill(child: CustomPaint(painter: _NotchPainter())),
          // Nav items (상단 64 영역에만)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64,
            child: Row(
              children: List.generate(BottomNavItem.values.length, (index) {
                final item = BottomNavItem.values[index];
                final isCenter = index == BottomNavItem.map.index;
                final isActive = currentIndex == index;

                if (isCenter) {
                  return Expanded(child: SizedBox.shrink());
                }

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
  static const double _notchHalfWidth = 28.0; // 노치 가로 반폭
  static const double _notchDepth = 22.0; // 위로 파이는 깊이
  static const double _edgeCurve = 12.0; // 진입/복귀 곡선 여유

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final x1 = cx - _notchHalfWidth; // 노치 왼쪽 끝
    final x2 = cx + _notchHalfWidth; // 노치 오른쪽 끝

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x1 - _edgeCurve, 0)
      // 왼쪽 진입: y=0 → 노치 최저점(-_notchDepth) 으로 내려가는 S커브
      ..cubicTo(
        x1 - _edgeCurve / 2,
        0, // 제어점1: 수평 유지
        x1,
        -_notchDepth, // 제어점2: 노치 깊이
        cx,
        -_notchDepth, // 노치 중앙 최저점
      )
      // 오른쪽 복귀: 노치 최저점 → y=0
      ..cubicTo(
        x2,
        -_notchDepth, // 제어점1: 노치 깊이
        x2 + _edgeCurve / 2,
        0, // 제어점2: 수평 유지
        x2 + _edgeCurve,
        0, // y=0 복귀
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, AppColors.gray300.withValues(alpha: 0.5), 4, false);
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
              color: AppColors.gray300.withValues(alpha: 0.3),
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
