import 'package:pedal/domain/map/entities/route_entity.dart';

class MapMockData {
  static const List<RouteEntity> routes = [
    RouteEntity(
      id: 'route_001',
      routeName: '한강 라이딩 코스',
      distance: 15.2,
      duration: '1h 15m',
      calories: 320,
    ),
    RouteEntity(
      id: 'route_002',
      routeName: '대청호 순환도로',
      distance: 32.5,
      duration: '2h 30m',
      calories: 680,
    ),
    RouteEntity(
      id: 'route_003',
      routeName: '엑스포 다리 코스',
      distance: 10.8,
      duration: '45m',
      calories: 240,
    ),
    RouteEntity(
      id: 'route_004',
      routeName: '갑천 자전거길',
      distance: 12.3,
      duration: '1h 5m',
      calories: 280,
    ),
    RouteEntity(
      id: 'route_005',
      routeName: '유성온천 순환',
      distance: 11.5,
      duration: '50m',
      calories: 260,
    ),
    RouteEntity(
      id: 'route_006',
      routeName: '계룡산 둘레길',
      distance: 42.1,
      duration: '3h 10m',
      calories: 890,
    ),
    RouteEntity(
      id: 'route_007',
      routeName: '보문산 힐클라이밍',
      distance: 8.7,
      duration: '1h 20m',
      calories: 350,
    ),
    RouteEntity(
      id: 'route_008',
      routeName: '도심 야간 라이딩',
      distance: 9.2,
      duration: '40m',
      calories: 210,
    ),
    RouteEntity(
      id: 'route_009',
      routeName: '둔산대공원 순환',
      distance: 7.5,
      duration: '35m',
      calories: 180,
    ),
    RouteEntity(
      id: 'route_010',
      routeName: '금강 자전거길',
      distance: 38.6,
      duration: '2h 45m',
      calories: 820,
    ),
  ];
}
