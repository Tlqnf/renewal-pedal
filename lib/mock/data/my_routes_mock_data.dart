import 'package:pedal/domain/my/entities/saved_route_entity.dart';

class MyRoutesMockData {
  static final SavedRouteEntity singleRoute = SavedRouteEntity(
    id: 'route_001',
    name: '금규 공원 경로',
    mapThumbnailUrl: null,
    distanceKm: 20.04,
    durationMinutes: 63,
    savedAt: DateTime(2025, 9, 1, 0, 31),
  );

  static final List<SavedRouteEntity> routeList = [
    SavedRouteEntity(
      id: 'route_001',
      name: '금규 공원 경로',
      mapThumbnailUrl: null,
      distanceKm: 20.04,
      durationMinutes: 63,
      savedAt: DateTime(2025, 9, 1, 0, 31),
    ),
    SavedRouteEntity(
      id: 'route_002',
      name: '한강 라이딩 코스',
      mapThumbnailUrl: null,
      distanceKm: 15.30,
      durationMinutes: 48,
      savedAt: DateTime(2025, 8, 20, 9, 15),
    ),
    SavedRouteEntity(
      id: 'route_003',
      name: '남산 순환 경로',
      mapThumbnailUrl: null,
      distanceKm: 8.75,
      durationMinutes: 35,
      savedAt: DateTime(2025, 8, 10, 14, 22),
    ),
    SavedRouteEntity(
      id: 'route_004',
      name: '올림픽공원 외곽',
      mapThumbnailUrl: null,
      distanceKm: 12.50,
      durationMinutes: 52,
      savedAt: DateTime(2025, 7, 28, 7, 5),
    ),
    SavedRouteEntity(
      id: 'route_005',
      name: '서울숲 산책로',
      mapThumbnailUrl: null,
      distanceKm: 6.80,
      durationMinutes: 28,
      savedAt: DateTime(2025, 7, 15, 18, 45),
    ),
  ];

  static const List<SavedRouteEntity> emptyList = [];
}
