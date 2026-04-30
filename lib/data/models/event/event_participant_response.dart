import 'package:pedal/domain/auth/entities/user_entity.dart';

class EventParticipantResponse {
  final String id;
  final String nickname;
  final String? profileImageUrl;

  const EventParticipantResponse({
    required this.id,
    required this.nickname,
    this.profileImageUrl,
  });

  factory EventParticipantResponse.fromJson(Map<String, dynamic> json) {
    return EventParticipantResponse(
      id: json['id'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String?,
    );
  }

  UserEntity toEntity() =>
      UserEntity(id: id, username: nickname, avatarUrl: profileImageUrl ?? '');
}
