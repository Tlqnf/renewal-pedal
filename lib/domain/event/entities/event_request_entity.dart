class EventRequestEntity {
  final String eventId;
  final String imagePath;
  final String? memo;

  const EventRequestEntity({
    required this.eventId,
    required this.imagePath,
    this.memo,
  });
}
