import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';
import 'package:pedal/features/map/widgets/record_summary_card.dart';
import 'package:pedal/features/map/widgets/recording_dashboard.dart';
import 'package:pedal/features/map/widgets/recording_controls.dart';
import 'package:pedal/features/map/widgets/map_control_button.dart';
import 'package:pedal/common/components/lists/record_summary_list.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/components/buttons/cancel_button.dart';
import 'package:pedal/common/components/buttons/add_button.dart';
import 'package:pedal/common/components/inputs/app_text_field.dart';
import 'package:pedal/common/components/inputs/app_toggle.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class RecordPage extends StatelessWidget {
  final MapViewModel mapViewModel;

  const RecordPage({super.key, required this.mapViewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: mapViewModel,
      child: const _RecordPageContent(),
    );
  }
}

class _RecordPageContent extends StatefulWidget {
  const _RecordPageContent();

  @override
  State<_RecordPageContent> createState() => _RecordPageContentState();
}

class _RecordPageContentState extends State<_RecordPageContent>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _recordSummary;
  final _routeNameController = TextEditingController();
  String? _routeNameError;
  bool _showRouteCard = true;
  bool _showFullDashboard = false;
  late final AnimationController _pauseBlinkController;

  // 피드 생성
  bool _createFeed = false;
  final _feedTitleController = TextEditingController();
  final _feedContentController = TextEditingController();
  String? _feedTitleError;
  final List<String> _feedImages = [];

  @override
  void initState() {
    super.initState();
    _pauseBlinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewModel>().showUserMarker = false;
    });
  }

  @override
  void dispose() {
    final vm = context.read<MapViewModel>();
    vm.showUserMarker = true;
    vm.resetRecording();
    _routeNameController.dispose();
    _feedTitleController.dispose();
    _feedContentController.dispose();
    _pauseBlinkController.dispose();
    super.dispose();
  }

  Future<void> _addFeedPhotos() async {
    final List<XFile> images = await ImagePicker().pickMultiImage(
      imageQuality: 90,
    );
    if (images.isNotEmpty) {
      setState(() {
        _feedImages.addAll(images.map((x) => x.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapViewModel>();
    final isActiveRecording = viewModel.isRecording || viewModel.isPaused;

    if (viewModel.isPaused) {
      _pauseBlinkController.repeat(reverse: true);
    } else {
      _pauseBlinkController.stop();
      _pauseBlinkController.value = 0;
    }

    if (isActiveRecording || _recordSummary != null) {
      final bottomPadding = MediaQuery.of(context).padding.bottom;
      const controlsBottom = 24;
      // 컨트롤러 높이: 아이콘36 + 패딩32 = 68
      const controlsHeight = 68.0;
      // 대시보드 bottom = controlsBottom + controlsHeight + gap
      const dashboardBottom = controlsBottom + controlsHeight + AppSpacing.lg;
      // 대시보드 높이: 텍스트(라벨subMedium14+값h3Bold20 + sm8) + 패딩32 ≈ 74
      const dashboardHeight = 74.0;
      // 경로 카드 bottom = dashboardBottom + dashboardHeight + gap
      const routeCardBottom = dashboardBottom + dashboardHeight + AppSpacing.lg;

      final topPadding = MediaQuery.of(context).padding.top;
      final hasRoute = viewModel.selectedRoute != null;

      return Scaffold(
        body: Stack(
          children: [
            // 1. 지도
            Positioned.fill(child: _buildMap(context, viewModel)),

            // 2. 전체화면 대시보드 패널 (지도 위, 일시정지 바 아래)
            if (_showFullDashboard)
              Positioned.fill(
                child: _buildFullDashboard(context, viewModel, hasRoute),
              ),

            // 3. 기록 중 UI (저장 Sheet가 없을 때만 표시)
            if (!_showFullDashboard && _recordSummary == null) ...[
              // 경로 카드
              if (hasRoute && _showRouteCard)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: bottomPadding + routeCardBottom + 24,
                  child: RecordSummaryCard(
                    routeName: viewModel.selectedRoute!.routeName,
                    distance: viewModel.selectedRoute!.distance,
                    duration: viewModel.selectedRoute!.duration,
                    calories: viewModel.selectedRoute!.calories,
                  ),
                ),

              // 대시보드
              Positioned(
                left: 16,
                right: 16,
                bottom: bottomPadding + dashboardBottom,
                child: RecordingDashboard(
                  timeElapsed: viewModel.time,
                  currentSpeed: viewModel.currentSpeed,
                  totalDistance: viewModel.distance,
                ),
              ),

              // 좌측 버튼 (경로 카드 on/off)
              Positioned(
                left: 16,
                bottom: bottomPadding + controlsBottom,
                child: MapControlButton(
                  icon: Icons.navigation,
                  onPressed: () {
                    if (hasRoute) {
                      setState(() => _showRouteCard = !_showRouteCard);
                    }
                  },
                ),
              ),

              // 중앙 컨트롤러
              Positioned(
                left: 0,
                right: 0,
                bottom: bottomPadding + controlsBottom,
                child: Center(
                  child: RecordingControls(
                    isPaused: viewModel.isPaused,
                    onPauseToggle: context
                        .read<MapViewModel>()
                        .pauseAndRecording,
                    onStop: () async {
                      final summary = await context
                          .read<MapViewModel>()
                          .stopRecording();
                      if (mounted) {
                        setState(() => _recordSummary = summary);
                      }
                    },
                  ),
                ),
              ),

              // 우측 버튼 (전체 대시보드 토글)
              Positioned(
                right: 16,
                bottom: bottomPadding + controlsBottom,
                child: MapControlButton(
                  icon: Icons.speed,
                  onPressed: () => setState(() => _showFullDashboard = true),
                ),
              ),
            ],

            // 4. 저장 Sheet (Stack 위에 직접 배치 → 지도 터치 가능)
            if (_recordSummary != null)
              Positioned.fill(
                child: DraggableScrollableSheet(
                  expand: true,
                  minChildSize: 0.35,
                  maxChildSize: 0.92,
                  initialChildSize: 0.6,
                  shouldCloseOnMinExtent: false,
                  builder: (_, scrollController) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.xl),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 드래그 핸들
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          _buildAfterRecordContent(context, viewModel),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // 5. 일시정지 바 (항상 최상단)
            if (viewModel.isPaused)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _pauseBlinkController,
                  child: Container(
                    color: AppColors.warning,
                    padding: EdgeInsets.only(
                      top: topPadding,
                      bottom: AppSpacing.md,
                    ),
                    child: Text(
                      '일시정지',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // beforeRecord
    return _buildBeforeRecordScaffold(context, viewModel);
  }

  Widget _buildMap(
    BuildContext context,
    MapViewModel viewModel, {
    bool registerController = true,
  }) {
    if (viewModel.isLoading || viewModel.currentUserLocation == null) {
      return const ColoredBox(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return NaverMap(
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
      onMapReady: registerController
          ? (controller) {
              context.read<MapViewModel>().onMapReady(controller);
            }
          : null,
      onCameraChange: (reason, animated) {
        if (reason == NCameraUpdateReason.gesture && viewModel.isFollowing) {
          context.read<MapViewModel>().isFollowingUser = false;
        }
      },
    );
  }

  Widget _buildBeforeRecordScaffold(
    BuildContext context,
    MapViewModel viewModel,
  ) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final route = viewModel.selectedRoute;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _buildMap(context, viewModel)),

          // 상단 뒤로가기 버튼
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.md,
            left: AppSpacing.lg,
            child: MapControlButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 선택된 경로 카드
          if (route != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: bottomPadding + 72 + AppSpacing.lg * 2,
              child: RecordSummaryCard(
                routeName: route.routeName,
                distance: route.distance,
                duration: route.duration,
                calories: route.calories,
                onClose: context.read<MapViewModel>().clearSelectedRoute,
              ),
            ),

          // 기록 시작 버튼
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomPadding + AppSpacing.lg,
            child: Center(
              child: GestureDetector(
                onTap: () => context.read<MapViewModel>().startRecording(),
                child: Image.asset(
                  'assets/images/record_button.png',
                  width: 72,
                  height: 72,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullDashboard(
    BuildContext context,
    MapViewModel viewModel,
    bool hasRoute,
  ) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const controlsBottom = 24;

    return ColoredBox(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

          // 현재 속력 (중앙)
          Text(
            '현재 속력 (km/h)',
            style: AppTextStyles.txtSm,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            viewModel.currentSpeed.toStringAsFixed(2),
            style: AppTextStyles.titXl.copyWith(fontSize: 48),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // 시간 | 거리 카드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildStatCard([
              _DashboardStat(label: '시간', value: viewModel.time),
              _DashboardStat(
                label: '거리 (km)',
                value: viewModel.distance.toStringAsFixed(2),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 칼로리 | 페이스 카드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildStatCard([
              const _DashboardStat(label: '칼로리 (kcal)', value: '0'),
              _DashboardStat(
                label: '페이스 (km/h)',
                value: viewModel.avgSpeed.toStringAsFixed(1),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),

          // 경로 카드
          if (hasRoute && _showRouteCard)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RecordSummaryCard(
                routeName: viewModel.selectedRoute!.routeName,
                distance: viewModel.selectedRoute!.distance,
                duration: viewModel.selectedRoute!.duration,
                calories: viewModel.selectedRoute!.calories,
              ),
            ),

          const Spacer(),

          // 하단 컨트롤 행
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: bottomPadding + controlsBottom,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MapControlButton(
                  icon: Icons.navigation,
                  onPressed: () {
                    if (hasRoute) {
                      setState(() => _showRouteCard = !_showRouteCard);
                    }
                  },
                ),
                RecordingControls(
                  isPaused: viewModel.isPaused,
                  onPauseToggle: context.read<MapViewModel>().pauseAndRecording,
                  onStop: () async {
                    final summary = await context
                        .read<MapViewModel>()
                        .stopRecording();
                    if (mounted) {
                      setState(() {
                        _recordSummary = summary;
                        _showFullDashboard = false;
                      });
                    }
                  },
                ),
                MapControlButton(
                  icon: Icons.speed,
                  onPressed: () => setState(() => _showFullDashboard = false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(List<_DashboardStat> stats) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          for (int i = 0; i < stats.length; i++) ...[
            if (i > 0)
              Container(
                width: 1,
                height: 48,
                color: AppColors.border,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    stats[i].label,
                    style: AppTextStyles.txtSm,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    stats[i].value,
                    style: AppTextStyles.titMdMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAfterRecordContent(
    BuildContext context,
    MapViewModel viewModel,
  ) {
    final summary = _recordSummary;
    final items = [
      RecordSummaryItem(
        label: '총 거리',
        value:
            '${(summary?['initialDistance'] as double? ?? 0.0).toStringAsFixed(2)} km',
      ),
      RecordSummaryItem(
        label: '총 소요시간',
        value: summary?['initialTime'] as String? ?? '00:00:00',
      ),
      RecordSummaryItem(
        label: '평균 속도',
        value:
            '${(summary?['initialAvgSpeed'] as double? ?? 0.0).toStringAsFixed(1)} km/h',
      ),
      RecordSummaryItem(
        label: '최고 속도',
        value:
            '${(summary?['initialMaxSpeed'] as double? ?? 0.0).toStringAsFixed(1)} km/h',
      ),
    ];

    return Container(
      color: AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RecordSummaryList(items: items),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 기록 이름
                AppTextField(
                  label: '기록 이름',
                  hintText: '기록 이름을 입력하세요',
                  controller: _routeNameController,
                  isRequired: true,
                  errorText: _routeNameError,
                  onChanged: (v) {
                    context.read<MapViewModel>().updateRideTitle(v);
                    if (_routeNameError != null) {
                      setState(() => _routeNameError = null);
                    }
                  },
                ),
                SizedBox(height: 24),

                // 피드 생성 토글
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('피드 생성', style: AppTextStyles.txtSm),
                    AppToggle(
                      value: _createFeed,
                      onChanged: (v) {
                        setState(() => _createFeed = v);
                        context.read<MapViewModel>().updateCreateFeedEnabled(v);
                      },
                    ),
                  ],
                ),

                // 피드 생성 ON일 때 필드 표시
                if (_createFeed) ...[
                  SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: '제목',
                    hintText: '게시글 제목을 입력하세요.',
                    controller: _feedTitleController,
                    isRequired: true,
                    errorText: _feedTitleError,
                    maxLines: 1,
                    onChanged: (v) {
                      context.read<MapViewModel>().updateFeedTitle(v);
                      if (_feedTitleError != null) {
                        setState(() => _feedTitleError = null);
                      }
                    },
                  ),
                  SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: '내용',
                    hintText: '게시글 내용을 작성하세요.',
                    controller: _feedContentController,
                    maxLines: 6,
                  ),
                  SizedBox(height: AppSpacing.lg),
                  AddButton(label: '사진 추가하기 (필수)', onPressed: _addFeedPhotos),
                  if (_feedImages.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: _feedImages.map((imagePath) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(imagePath),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _feedImages.remove(imagePath));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(AppSpacing.xs),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ],

                SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: CancelButton(
                        label: '취소',
                        onPressed: () {
                          context.read<MapViewModel>().resetRecording();
                          setState(() {
                            _recordSummary = null;
                            _routeNameController.clear();
                            _routeNameError = null;
                            _createFeed = false;
                            _feedTitleController.clear();
                            _feedContentController.clear();
                            _feedTitleError = null;
                            _feedImages.clear();
                          });
                          Navigator.pop(context); // RecordPage 닫기
                        },
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PrimaryButton(
                        label: '저장',
                        disabled: !viewModel.canSaveRide,
                        onPressed: viewModel.canSaveRide
                            ? () async {
                                // 기록 이름 / 피드 제목은 canSaveRide로 이미 검증됨
                                final name = _routeNameController.text.trim();
                                final nav = Navigator.of(context);
                                final mapViewModel = context
                                    .read<MapViewModel>();

                                // summary에서 데이터 추출
                                final startedAt =
                                    summary?['startedAt'] as DateTime? ??
                                    DateTime.now();
                                final durationSec =
                                    summary?['durationSec'] as int? ?? 0;
                                final distanceKm =
                                    summary?['initialDistance'] as double? ??
                                    0.0;
                                final routeCoords =
                                    (summary?['routeCoords'] as List?)
                                        ?.map(
                                          (c) => List<double>.from(c as List),
                                        )
                                        .toList() ??
                                    [];

                                // 라이딩 저장 API 호출
                                final rideId = await mapViewModel
                                    .saveFinishedRide(
                                      title: name,
                                      startedAt: startedAt,
                                      endedAt: DateTime.now(),
                                      distanceM: (distanceKm * 1000).toInt(),
                                      durationSec: durationSec,
                                      caloriesKcal: null,
                                      routeCoords: routeCoords,
                                      saveAsRoute: true,
                                      routeName: name,
                                    );

                                // 피드 생성 (기록 종료 후 저장 시에만)
                                if (_createFeed) {
                                  final feedTitle = _feedTitleController.text
                                      .trim();
                                  final feedContent = _feedContentController
                                      .text
                                      .trim();
                                  await mapViewModel.createFeed(
                                    title: feedTitle,
                                    content: feedContent.isEmpty
                                        ? null
                                        : feedContent,
                                    rideId: rideId,
                                    files: _feedImages
                                        .map((p) => File(p))
                                        .toList(),
                                  );
                                }

                                if (mounted) {
                                  mapViewModel.resetRecording();
                                  nav.pop(); // RecordPage 닫기
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _DashboardStat {
  final String label;
  final String value;

  const _DashboardStat({required this.label, required this.value});
}
