import 'package:pedal/domain/my/entities/crew_entity.dart';

class CrewDetailResponse {
  final String id;
  final String imageUrl;
  final String name;
  final String location;
  final int memberCount;
  final String? description;
  final List<String> crewTypes;
  final bool isPublic;
  final String? ownerId;
  final String? createdAt;
  final bool isJoined;
  final bool isOwner;
  final bool isAdmin;

  const CrewDetailResponse({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.memberCount,
    this.description,
    this.crewTypes = const [],
    this.isPublic = true,
    this.ownerId,
    this.createdAt,
    this.isJoined = false,
    this.isOwner = false,
    this.isAdmin = false,
  });

  factory CrewDetailResponse.fromJson(Map<String, dynamic> json) {
    final crewTypeData = json['crew_type'];
    List<String> crewTypes = [];
    if (crewTypeData is List) {
      crewTypes = (crewTypeData).map((e) => e.toString()).toList();
    } else if (crewTypeData is String) {
      crewTypes = [crewTypeData];
    }

    return CrewDetailResponse(
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
      description: json['description'] as String?,
      crewTypes: crewTypes,
      isPublic: json['is_public'] as bool? ?? true,
      ownerId: json['owner_id'] is int
          ? (json['owner_id'] as int).toString()
          : json['owner_id'] as String?,
      createdAt: json['created_at'] as String?,
      isJoined: json['is_joined'] as bool? ?? false,
      isOwner: json['is_owner'] as bool? ?? false,
      isAdmin: json['is_admin'] as bool? ?? false,
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
