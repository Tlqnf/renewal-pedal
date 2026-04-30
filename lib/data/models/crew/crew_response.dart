import 'package:pedal/domain/my/entities/crew_entity.dart';

class CrewResponse {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final int memberCount;

  const CrewResponse({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.memberCount,
  });

  factory CrewResponse.fromJson(Map<String, dynamic> json) {
    return CrewResponse(
      id: json['id'] is int
          ? (json['id'] as int).toString()
          : json['id'] as String? ?? '',
      imageUrl:
          json['cover_image_url'] as String? ??
          json['image_url'] as String? ??
          '',
      name: json['name'] as String? ?? '',
      location: json['location'] as String? ?? '',
      memberCount: json['member_count'] as int? ?? 0,
    );
  }

  CrewEntity toEntity() => CrewEntity(
    id: id,
    name: name,
    imageUrl: imageUrl,
    location: location,
    memberCount: memberCount,
  );
}
