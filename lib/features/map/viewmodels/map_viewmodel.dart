import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/feed/use_cases/create_feed_usecase.dart';
import 'package:pedal/domain/map/use_cases/ai_recommend_route_usecase.dart';
import 'package:pedal/domain/map/use_cases/get_saved_routes_usecase.dart';
import 'package:pedal/domain/map/use_cases/finish_ride_usecase.dart';
import 'package:pedal/domain/map/use_cases/get_ride_track_usecase.dart';

enum RecordingStatus { idle, recording, paused }

class MapViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final FinishRideUseCase _finishRideUseCase;
  final GetSavedRoutesUseCase _getSavedRoutesUseCase;
  final AiRecommendRouteUseCase _aiRecommendRouteUseCase;
  final GetRideTrackUseCase _getRideTrackUseCase;
  final CreateFeedUseCase _createFeedUseCase;

  MapViewModel(
    this._finishRideUseCase,
    this._getSavedRoutesUseCase,
    this._aiRecommendRouteUseCase,
    this._getRideTrackUseCase,
    this._createFeedUseCase,
  );
  // 지도 컨트롤러
  NaverMapController? _mapController;
  bool _isDisposed = false;

  // 위치 스트림
  StreamSubscription<Position>? _positionStreamSubscription;

  // 사용자 위치
  NLatLng? _currentUserLocation;
  bool _isFollowing = true;

  // 로딩 / 가시성
  bool _isLoading = false;
  bool _isMapVisible = true;

  // 기록 상태
  RecordingStatus _recordingStatus = RecordingStatus.idle;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _time = '00:00:00';
  DateTime? _lastTimestamp;
  DateTime? _recordingStartTime;

  double _distance = 0.0;
  double _avgSpeed = 0.0;
  double _currentSpeed = 0.0;
  double _maxSpeed = 0.0;

  // 경로 chunk
  final int _chunkSize = 25;
  final List<List<NLatLng>> _routeChunks = [[]];

  // 내비게이션 경로
  NPathOverlay? _navigationPath;

  // 경로 상세 (RoutingFeedDetailPage에서 사용)
  RouteEntity? _routeDetail;

  // 검색에서 선택된 루트 (RecordSummaryCard 표시용)
  RouteEntity? _selectedRoute;

  // 사용자 위치 마커 표시 여부
  bool _showUserMarker = true;

  // 기록 저장 폼 상태
  String _rideTitle = '';
  bool _createFeedEnabled = false;
  String _feedTitle = '';

  // ──────────────────────────── Getters ────────────────────────────

  NaverMapController? get mapController => _mapController;
  NLatLng? get currentUserLocation => _currentUserLocation;
  RouteEntity? get routeDetail => _routeDetail;
  RouteEntity? get selectedRoute => _selectedRoute;
  bool get isFollowing => _isFollowing;
  set showUserMarker(bool value) => _showUserMarker = value;
  bool get isLoading => _isLoading;
  bool get isMapVisible => _isMapVisible;
  bool get isRecording => _recordingStatus == RecordingStatus.recording;
  bool get isPaused => _recordingStatus == RecordingStatus.paused;
  String get time => _time;
  double get distance => _distance;
  double get avgSpeed => _avgSpeed;
  double get currentSpeed => _currentSpeed;
  double get maxSpeed => _maxSpeed;

  // 기록 저장 폼
  bool get canSaveRide {
    if (_rideTitle.trim().isEmpty) return false;
    if (_createFeedEnabled && _feedTitle.trim().isEmpty) return false;
    return true;
  }

  void updateRideTitle(String value) {
    _rideTitle = value;
    notifyListeners();
  }

  void updateCreateFeedEnabled(bool value) {
    _createFeedEnabled = value;
    notifyListeners();
  }

  void updateFeedTitle(String value) {
    _feedTitle = value;
    notifyListeners();
  }

  // ──────────────────────────── Setters ────────────────────────────

  set isFollowingUser(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  // ──────────────────────────── Lifecycle ────────────────────────────

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if ((state == AppLifecycleState.paused ||
            state == AppLifecycleState.inactive) &&
        _recordingStatus == RecordingStatus.idle) {
      // 기록 중이 아닐 때 백그라운드 진입 시 알림 취소 (stub)
      _cancelTrackingNotification();
    }
    if (state == AppLifecycleState.resumed &&
        _recordingStatus == RecordingStatus.idle) {
      _cancelTrackingNotification();
    }
  }

  // ──────────────────────────── 초기화 ────────────────────────────

  Future<void> initialize() async {
    WidgetsBinding.instance.addObserver(this);
    _isLoading = true;
    notifyListeners();

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('위치 서비스가 비활성화되어 있습니다.');
      _isLoading = false;
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('위치 권한이 거부되었습니다.');
        _isLoading = false;
        notifyListeners();
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint('위치 권한이 영구적으로 거부되었습니다.');
      _isLoading = false;
      notifyListeners();
      return;
    }

    // 마지막으로 알려진 위치로 빠르게 초기화
    final lastPos = await Geolocator.getLastKnownPosition();
    if (lastPos != null) {
      _currentUserLocation = NLatLng(lastPos.latitude, lastPos.longitude);
      _isLoading = false;
      notifyListeners();
    }

    // 정확한 현재 위치로 갱신
    try {
      final currentPos = await Geolocator.getCurrentPosition();
      _currentUserLocation = NLatLng(currentPos.latitude, currentPos.longitude);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('현재 위치를 불러오는데 실패했습니다: $e');
    }

    _subscribePositionStream();
    notifyListeners();
  }

  // ──────────────────────────── 위치 스트림 ────────────────────────────

  void _subscribePositionStream() {
    _positionStreamSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
          ),
        ).listen((Position pos) {
          if (_isDisposed || _mapController == null) return;

          final newPoint = NLatLng(pos.latitude, pos.longitude);

          // 사용자 위치 마커 갱신 및 카메라 따라가기
          try {
            if (_showUserMarker) {
              final marker = NMarker(id: 'user_pos', position: newPoint);
              _mapController?.addOverlay(marker);
            }

            if (_isFollowing) {
              _mapController?.updateCamera(
                NCameraUpdate.scrollAndZoomTo(target: newPoint, zoom: 16.0),
              );
            }
          } catch (e) {
            // dispose된 컨트롤러 채널 오류 처리
            debugPrint('MapController 오류 (dispose된 컨트롤러): $e');
            _mapController = null;
          }

          if (_recordingStatus == RecordingStatus.recording) {
            _recordingLogic(newPoint, pos);
          } else {
            _currentUserLocation = newPoint;
            notifyListeners();
          }
        });
  }

  // ──────────────────────────── 기록 로직 ────────────────────────────

  void _recordingLogic(NLatLng newPoint, Position pos) {
    final lastPoint = _currentUserLocation;
    final lastTimestamp = _lastTimestamp;

    if (lastPoint == null) return;

    // 첫 위치일 경우 초기화 후 종료
    if (lastTimestamp == null) {
      _currentUserLocation = newPoint;
      _lastTimestamp = pos.timestamp;
      return;
    }

    // 거리 계산 (km)
    final segmentDistance =
        Geolocator.distanceBetween(
          lastPoint.latitude,
          lastPoint.longitude,
          newPoint.latitude,
          newPoint.longitude,
        ) *
        0.001;

    if (segmentDistance > 0.001 && segmentDistance < 0.5) {
      _distance += segmentDistance;
    }

    // 속력 계산
    _currentSpeed = pos.speed * 3.6;
    if (_currentSpeed > _maxSpeed && _currentSpeed < 100) {
      _maxSpeed = _currentSpeed;
    }

    // 평균 속력
    final elapsedSeconds = _stopwatch.elapsed.inSeconds;
    if (elapsedSeconds > 0) {
      _avgSpeed = (_distance / elapsedSeconds) * 3600;
    }

    _currentUserLocation = newPoint;
    _lastTimestamp = pos.timestamp;

    _addPointToRoute(newPoint);
    notifyListeners();
  }

  void _addPointToRoute(NLatLng point) {
    var lastChunk = _routeChunks.last;
    if (lastChunk.length >= _chunkSize) {
      final lastPoint = lastChunk.last;
      _routeChunks.add([lastPoint]);
      lastChunk = _routeChunks.last;
    }
    lastChunk.add(point);

    if (_mapController != null && lastChunk.length >= 2) {
      final chunkIndex = _routeChunks.length - 1;
      final pathOverlay = NPathOverlay(
        id: 'route_chunk_$chunkIndex',
        coords: lastChunk,
        width: 6,
        color: AppColors.primary,
        outlineWidth: 2,
        outlineColor: AppColors.surface,
      );
      _mapController!.addOverlay(pathOverlay);
    }
  }

  // ──────────────────────────── 기록 제어 ────────────────────────────

  Future<void> startRecording() async {
    _showUserMarker = true;
    _recordingStatus = RecordingStatus.recording;
    _lastTimestamp = null;
    _recordingStartTime = DateTime.now();
    _stopwatch
      ..reset()
      ..start();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _time = _formatTime(_stopwatch.elapsed.inSeconds);
      notifyListeners();
    });
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));

    if (_isDisposed || _mapController == null) return;

    if (_navigationPath == null) {
      await _mapController?.clearOverlays();
    }

    if (_mapController != null && _currentUserLocation != null) {
      final marker = NMarker(id: 'user_pos', position: _currentUserLocation!);
      await _mapController?.addOverlay(marker);
    }
  }

  void pauseAndRecording() {
    if (_recordingStatus == RecordingStatus.idle) return;

    _recordingStatus = _recordingStatus == RecordingStatus.recording
        ? RecordingStatus.paused
        : RecordingStatus.recording;

    if (_recordingStatus == RecordingStatus.paused) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>?> stopRecording() async {
    if (_recordingStatus == RecordingStatus.idle) return null;

    if (_navigationPath != null) {
      stopNavigation();
    }

    _stopwatch.stop();
    _timer?.cancel();
    _recordingStatus = RecordingStatus.idle;
    notifyListeners();

    final distance = _distance;
    final time = _time;
    final avgSpeed = _avgSpeed;
    final maxSpeed = _maxSpeed;
    final fullRoute = _routeChunks.expand((c) => c).toList();
    final routeCoords = fullRoute
        .map((p) => [p.latitude, p.longitude])
        .toList();
    final startedAt = _recordingStartTime;
    final durationSec = _stopwatch.elapsed.inSeconds;

    // 측정 데이터 즉시 초기화 (폼 상태는 resetRecording에서 처리)
    _distance = 0.0;
    _avgSpeed = 0.0;
    _currentSpeed = 0.0;
    _maxSpeed = 0.0;
    _time = '00:00:00';
    _lastTimestamp = null;
    _recordingStartTime = null;
    _routeChunks
      ..clear()
      ..add([]);

    String? snapshotPath;
    if (_mapController != null) {
      NCameraUpdate cameraUpdate;
      if (fullRoute.isNotEmpty) {
        final bounds = NLatLngBounds.from(fullRoute);
        cameraUpdate = NCameraUpdate.fitBounds(
          bounds,
          padding: const EdgeInsets.all(80),
        );
        final distanceMeters = _calculateRouteDistance(fullRoute);
        final durationMs = (distanceMeters / 500).clamp(500, 3000).toInt();
        cameraUpdate.setAnimation(
          animation: NCameraAnimation.linear,
          duration: Duration(milliseconds: durationMs),
        );
      } else {
        cameraUpdate = NCameraUpdate.withParams(target: _currentUserLocation);
        cameraUpdate.setAnimation(animation: NCameraAnimation.none);
      }

      await _mapController!.updateCamera(cameraUpdate);
      await Future.delayed(const Duration(milliseconds: 500));

      if (_isDisposed || _mapController == null) return null;

      final imageFile = await _mapController!.takeSnapshot();
      snapshotPath = imageFile.path;

      recenterMap();
      await _mapController?.clearOverlays();
      if (_currentUserLocation != null) {
        final marker = NMarker(id: 'user_pos', position: _currentUserLocation!);
        _mapController?.addOverlay(marker);
      }
    }

    return {
      'initialDistance': distance,
      'initialTime': time,
      'initialAvgSpeed': avgSpeed,
      'initialMaxSpeed': maxSpeed,
      'mapImagePath': snapshotPath,
      'routeCoords': routeCoords,
      'startedAt': startedAt,
      'durationSec': durationSec,
    };
  }

  void resetRecording() {
    _stopwatch.stop();
    _timer?.cancel();
    _recordingStatus = RecordingStatus.idle;
    _stopwatch.reset();
    _isMapVisible = true;
    _distance = 0.0;
    _avgSpeed = 0.0;
    _currentSpeed = 0.0;
    _maxSpeed = 0.0;
    _time = '00:00:00';
    _lastTimestamp = null;
    _recordingStartTime = null;
    _routeChunks
      ..clear()
      ..add([]);
    _rideTitle = '';
    _createFeedEnabled = false;
    _feedTitle = '';
    _cancelTrackingNotification();
    notifyListeners();
  }

  // ──────────────────────────── 지도 제어 ────────────────────────────

  void onMapReady(NaverMapController controller) {
    _mapController = controller;
    if (_currentUserLocation != null) {
      controller.updateCamera(
        NCameraUpdate.scrollAndZoomTo(
          target: _currentUserLocation!,
          zoom: 16.0,
        ),
      );
    }
    // 기존 네비게이션 경로 재등록 (지도 위젯 재생성 시 오버레이 복원)
    if (_navigationPath != null) {
      try {
        _mapController!.addOverlay(_navigationPath!);
      } catch (e) {
        debugPrint('네비게이션 경로 재등록 오류: $e');
      }
    }
    // 이미 구독 중이면 재구독 안 함 (중복 구독 방지)
    if (_positionStreamSubscription == null) {
      _subscribePositionStream();
    }
    notifyListeners();
  }

  void recenterMap() {
    if (_currentUserLocation == null || _mapController == null) return;
    _isFollowing = true;
    _mapController!.updateCamera(
      NCameraUpdate.scrollAndZoomTo(target: _currentUserLocation!, zoom: 16.5),
    );
    notifyListeners();
  }

  void mapVisibility() {
    _isMapVisible = !_isMapVisible;
    if (_isMapVisible) {
      _positionStreamSubscription?.resume();
    } else {
      _positionStreamSubscription?.pause();
    }
    notifyListeners();
  }

  // ──────────────────────────── 내비게이션 ────────────────────────────

  Future<void> startNavigation(List<NLatLng> routeCoords) async {
    if (_mapController == null || routeCoords.length < 2) return;
    _clearNavigationPath();

    _navigationPath = NPathOverlay(
      id: 'navigation_path',
      coords: routeCoords,
      width: 6,
      color: AppColors.error,
      outlineWidth: 2,
      outlineColor: AppColors.surface,
    );

    try {
      await _mapController!.addOverlay(_navigationPath!);
      final bounds = NLatLngBounds.from(routeCoords);
      await _mapController!.updateCamera(
        NCameraUpdate.fitBounds(bounds, padding: const EdgeInsets.all(80)),
      );
    } catch (e) {
      debugPrint('내비게이션 경로 오버레이 오류: $e');
    }
    notifyListeners();
  }

  void stopNavigation() {
    _clearNavigationPath();
    notifyListeners();
  }

  void _clearNavigationPath() {
    if (_navigationPath != null) {
      try {
        _mapController?.deleteOverlay(_navigationPath!.info);
      } catch (e) {
        debugPrint('경로 오버레이 삭제 오류: $e');
      }
      _navigationPath = null;
    }
  }

  // ──────────────────────────── 알림 (stub) ────────────────────────────

  // flutter_local_notifications 미설치 → 추후 구현
  void _cancelTrackingNotification() {}

  // ──────────────────────────── 내부 유틸 ────────────────────────────

  String _formatTime(int totalSeconds) {
    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final s = totalSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double _calculateRouteDistance(List<NLatLng> points) {
    double total = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      total += Geolocator.distanceBetween(
        points[i].latitude,
        points[i].longitude,
        points[i + 1].latitude,
        points[i + 1].longitude,
      );
    }
    return total;
  }

  // ──────────────────────────── 선택 루트 ────────────────────────────

  void setSelectedRoute(RouteEntity route) {
    _selectedRoute = route;
    notifyListeners();
  }

  void clearSelectedRoute() {
    _selectedRoute = null;
    notifyListeners();
  }

  Future<void> activateNavigation(RouteEntity route) async {
    setSelectedRoute(route);
    final rideId = route.rideId;
    if (rideId == null) return;
    final result = await _getRideTrackUseCase.execute(rideId);
    result.fold((failure) => debugPrint('트랙 로드 실패: ${failure.message}'), (
      coords,
    ) async {
      final nCoords = coords.map((c) => NLatLng(c[0], c[1])).toList();
      await startNavigation(nCoords);
    });
  }

  void clearNavigationState() {
    clearSelectedRoute();
    stopNavigation();
  }

  // ──────────────────────────── 경로 상세 ────────────────────────────

  Future<void> loadRouteDetail() async {
    final result = await _getSavedRoutesUseCase.execute();
    result.fold((failure) => debugPrint('저장된 루트 로드 실패: ${failure.message}'), (
      routes,
    ) {
      if (routes.isNotEmpty) {
        _routeDetail = routes.first;
        notifyListeners();
      }
    });
  }

  // ──────────────────────────── 라이딩 종료 저장 ────────────────────────────

  Future<String?> saveFinishedRide({
    required String? title,
    required DateTime startedAt,
    required DateTime endedAt,
    required int distanceM,
    required int durationSec,
    required int? caloriesKcal,
    required List<List<double>> routeCoords,
    bool saveAsRoute = false,
    String? routeName,
  }) async {
    final points = routeCoords.map((c) => {'lat': c[0], 'lng': c[1]}).toList();

    final result = await _finishRideUseCase.execute(
      title: title,
      startedAt: startedAt,
      endedAt: endedAt,
      distanceM: distanceM,
      durationSec: durationSec,
      caloriesKcal: caloriesKcal,
      visibility: 'public',
      points: points,
      saveAsRoute: saveAsRoute,
      routeName: routeName,
    );

    return result.fold(
      (failure) {
        debugPrint('라이딩 저장 실패: ${failure.message}');
        return null;
      },
      (ride) {
        debugPrint('라이딩 저장 완료: ${ride.id}');
        return ride.id;
      },
    );
  }

  Future<void> createFeed({
    required String title,
    String? content,
    String? rideId,
    List<File> files = const [],
  }) async {
    final result = await _createFeedUseCase.execute(
      title: title,
      content: content,
      rideId: rideId,
      files: files,
    );
    result.fold(
      (failure) => debugPrint('피드 생성 실패: ${failure.message}'),
      (_) => debugPrint('피드 생성 완료'),
    );
  }

  // ──────────────────────────── AI 경로 추천 ────────────────────────────

  Future<List<RouteEntity>> recommendRoute(Map<String, dynamic> params) async {
    final result = await _aiRecommendRouteUseCase.execute(params);
    return result.fold((failure) {
      debugPrint('AI 경로 추천 실패: ${failure.message}');
      return [];
    }, (routes) => routes);
  }

  // ──────────────────────────── dispose ────────────────────────────

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _positionStreamSubscription?.cancel();
    _timer?.cancel();
    _mapController?.dispose();
    _cancelTrackingNotification();
    super.dispose();
  }
}
