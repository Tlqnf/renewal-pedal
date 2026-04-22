class CrewEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final String location;
  final int memberCount;

  const CrewEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.location,
    required this.memberCount,
  });
}
