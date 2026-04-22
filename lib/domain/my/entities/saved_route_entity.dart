class SavedRouteEntity {
  final String id;
  final String name;
  final String? mapThumbnailUrl;
  final double distanceKm;
  final int durationMinutes;
  final DateTime savedAt;

  const SavedRouteEntity({
    required this.id,
    required this.name,
    this.mapThumbnailUrl,
    required this.distanceKm,
    required this.durationMinutes,
    required this.savedAt,
  });
}
