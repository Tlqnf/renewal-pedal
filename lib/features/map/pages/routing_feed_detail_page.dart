import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/cards/route_info_card.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';
import 'package:pedal/features/map/widgets/map_control_button.dart';

class RoutingFeedDetailPage extends StatefulWidget {
  final String routeId;

  const RoutingFeedDetailPage({super.key, required this.routeId});

  @override
  State<RoutingFeedDetailPage> createState() => _RoutingFeedDetailPageState();
}

class _RoutingFeedDetailPageState extends State<RoutingFeedDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewModel>().loadRouteDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.routeDetail == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final route = viewModel.routeDetail!;
        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Stack(
              children: [
                // 지도 영역 (향후 flutter_naver_map 사용)
                Container(
                  color: AppColors.border,
                  child: Center(
                    child: Text(
                      'NaverMap Placeholder\n(flutter_naver_map 통합 예정)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),

                // 상단 뒤로가기 버튼
                Positioned(
                  top: MediaQuery.of(context).padding.top + AppSpacing.md,
                  left: AppSpacing.lg,
                  child: MapControlButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // 하단 경로 정보 카드
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: RecordInfoCard(
                    title: route.routeName,
                    distance: '${route.distance}km',
                    duration: route.duration,
                    isBookmarked: false,
                    onBookmarkTap: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
