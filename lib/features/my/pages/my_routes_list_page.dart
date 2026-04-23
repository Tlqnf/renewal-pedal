import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/features/my/widgets/route_card.dart';

class MyRoutesListPage extends StatelessWidget {
  final List<SavedRouteEntity> routeList;
  final int routeCount;
  final bool isLoading;
  final String? errorMessage;

  final VoidCallback onBack;
  final void Function(String id) onRouteTap;

  const MyRoutesListPage({
    super.key,
    required this.routeList,
    required this.routeCount,
    required this.isLoading,
    required this.errorMessage,
    required this.onBack,
    required this.onRouteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BackAppBar(
        title: '저장된 경로',
        onBackPressed: onBack,
        actions: [
          Text(
            '$routeCount',
            style: AppTextStyles.titMd.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: AppTextStyles.txtMd.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    if (routeList.isEmpty) {
      return Center(
        child: Text(
          '저장된 경로가 없습니다',
          style: AppTextStyles.txtMd.copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: routeList.length,
      separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final route = routeList[index];
        return RouteCard(
          route: route,
          onTap: () => onRouteTap(route.id),
        );
      },
    );
  }
}
