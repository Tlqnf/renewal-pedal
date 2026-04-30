class RouteEntity {
  final String id;
  final String? rideId;
  final String routeName;
  final double distance;
  final String duration;
  final int calories;
  final List<List<double>>? routeCoords;

  const RouteEntity({
    required this.id,
    this.rideId,
    required this.routeName,
    required this.distance,
    required this.duration,
    required this.calories,
    this.routeCoords,
  });
}
