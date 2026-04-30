import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';
import 'package:pedal/common/components/inputs/search_field.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/core/routes/app_routes.dart';
// import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/features/map/widgets/record_summary_card.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/features/map/widgets/map_control_button.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MapPageContent();
  }
}

class _MapPageContent extends StatefulWidget {
  const _MapPageContent();

  @override
  State<_MapPageContent> createState() => _MapPageContentState();
}

class _MapPageContentState extends State<_MapPageContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();
    final viewModelReader = context.read<MapViewModel>();

    if (viewModel.isLoading || viewModel.currentUserLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 지도 영역
          Positioned.fill(
            child: NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: viewModel.currentUserLocation!,
                  zoom: 16.0,
                ),
                locationButtonEnable: false,
                consumeSymbolTapEvents: false,
                mapType: NMapType.basic,
                buildingHeight: 0.0,
                indoorEnable: false,
                liteModeEnable: true,
                symbolScale: 0.0,
                nightModeEnable: false,
              ),
              onMapReady: (controller) {
                viewModelReader.onMapReady(controller);
              },
              onCameraChange: (reason, animated) {
                if (reason == NCameraUpdateReason.gesture &&
                    viewModel.isFollowing) {
                  viewModelReader.isFollowingUser = false;
                }
              },
            ),
          ),

          // 기록 전 오버레이
          _PreRecordingOverlay(
            viewModel: viewModel,
            viewModelReader: viewModelReader,
          ),
        ],
      ),
    );
  }
}

class _PreRecordingOverlay extends StatefulWidget {
  final MapViewModel viewModel;
  final MapViewModel viewModelReader;

  const _PreRecordingOverlay({
    required this.viewModel,
    required this.viewModelReader,
  });

  @override
  State<_PreRecordingOverlay> createState() => _PreRecordingOverlayState();
}

class _PreRecordingOverlayState extends State<_PreRecordingOverlay> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 상단 검색 필드
        Positioned(
          top: MediaQuery.of(context).padding.top + AppSpacing.md,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          child: SearchField(
            hintText: '장소 또는 루트 검색',
            controller: _searchController,
            onChanged: (_) {},
            onSubmitted: (query) async {
              await context.push(AppRoutes.mapSearch, extra: query);
            },
          ),
        ),

        // 우측 지도 컨트롤 버튼
        Positioned(
          top:
              MediaQuery.of(context).padding.top +
              AppSpacing.md +
              56 +
              AppSpacing.lg,
          right: 16,
          child: Column(
            children: [
              MapControlButton(
                icon: Icons.explore,
                onPressed: () => widget.viewModelReader.mapController
                    ?.updateCamera(NCameraUpdate.withParams(bearing: 0)),
              ),
              SizedBox(height: AppSpacing.sm),
              MapControlButton(
                icon: Icons.my_location,
                onPressed: widget.viewModelReader.recenterMap,
              ),
            ],
          ),
        ),

        // 하단: 선택된 루트 카드 + 기록 버튼
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: MediaQuery.of(context).padding.bottom + AppSpacing.xl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.viewModel.selectedRoute != null) ...[
                RecordSummaryCard(
                  routeName: widget.viewModel.selectedRoute!.routeName,
                  distance: widget.viewModel.selectedRoute!.distance,
                  duration: widget.viewModel.selectedRoute!.duration,
                  calories: widget.viewModel.selectedRoute!.calories,
                  onClose: widget.viewModelReader.clearNavigationState,
                ),
                SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  label: '경로 기록하기',
                  onPressed: () => context.push(AppRoutes.record),
                ),
              ] else
                PrimaryButton(
                  label: '경로 기록하기',
                  onPressed: () => context.push(AppRoutes.record),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
