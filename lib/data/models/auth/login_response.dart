import 'package:pedal/domain/auth/entities/auth_result_entity.dart';

class OAuthLoginResponse {
  final bool isNewUser;
  final String? signupToken;
  final String? email;
  final String? nickname;
  final String? accessToken;
  final String? refreshToken;
  final String tokenType;

  const OAuthLoginResponse({
    required this.isNewUser,
    this.signupToken,
    this.email,
    this.nickname,
    this.accessToken,
    this.refreshToken,
    this.tokenType = 'bearer',
  });

  factory OAuthLoginResponse.fromJson(Map<String, dynamic> json) {
    return OAuthLoginResponse(
      isNewUser: json['is_new_user'] as bool,
      signupToken: json['signup_token'] as String?,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }

  AuthResultEntity toEntity() => AuthResultEntity(
    isNewUser: isNewUser,
    signupToken: signupToken,
    accessToken: accessToken,
    refreshToken: refreshToken,
    email: email,
    nickname: nickname,
  );
}
