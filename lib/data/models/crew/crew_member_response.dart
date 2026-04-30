import 'package:pedal/domain/auth/entities/user_entity.dart';

class CrewMemberResponse {
  final String id;
  final String username;
  final String avatarUrl;
  final String? bio;

  const CrewMemberResponse({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.bio,
  });

  factory CrewMemberResponse.fromJson(Map<String, dynamic> json) {
    return CrewMemberResponse(
      id: (json['id'] as int?)?.toString() ?? json['id'] as String? ?? '',
      username: json['username'] as String? ?? json['name'] as String? ?? '',
      avatarUrl:
          json['avatar_url'] as String? ??
          json['profile_image_url'] as String? ??
          '',
      bio: json['bio'] as String?,
    );
  }

  UserEntity toEntity() =>
      UserEntity(id: id, username: username, avatarUrl: avatarUrl, bio: bio);
}
