import 'package:pedal/domain/auth/entities/user_entity.dart';

class ParticipantResponse {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? bio;

  ParticipantResponse({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.bio,
  });

  factory ParticipantResponse.fromJson(Map<String, dynamic> json) {
    return ParticipantResponse(
      id: json['user_id'] as String,
      username: json['nickname'] as String,
      avatarUrl: json['profile_image_url'] as String?,
      bio: null,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      avatarUrl: avatarUrl ?? '',
      bio: bio,
    );
  }
}
