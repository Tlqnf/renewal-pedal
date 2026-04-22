class EventEntity {
  final String id;
  final String title;
  final String subtitle;
  final List<String> imageUrls;

  const EventEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrls,
  });
}
