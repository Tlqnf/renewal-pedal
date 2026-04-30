import 'package:pedal/core/config/app_config.dart';
import 'package:pedal/domain/auth/entities/user_entity.dart';

class MeResponse {
  final String id;
  final String username;
  final String avatarUrl;
  final String? bio;

  MeResponse({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.bio,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    // GET /users/me 응답: {"user": {...}, ...}
    final userJson = (json['user'] as Map<String, dynamic>?) ?? json;
    final rawUrl =
        (userJson['profile_image_url'] ??
                userJson['profile_image'] ??
                userJson['avatar_url'] ??
                '')
            as String;
    final avatarUrl = rawUrl.isNotEmpty && rawUrl.startsWith('/')
        ? '${AppConfig.baseUrl.replaceAll(RegExp(r'/$'), '')}$rawUrl'
        : rawUrl;
    return MeResponse(
      id: (userJson['id'] ?? '') as String,
      username:
          (userJson['nickname'] ??
                  userJson['username'] ??
                  userJson['name'] ??
                  '')
              as String,
      avatarUrl: avatarUrl,
      bio: userJson['bio'] as String?,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
      bio: bio,
    );
  }
}
