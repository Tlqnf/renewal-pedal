/// Google ID token 또는 Kakao access token을 서버로 전송하는 공용 요청 DTO.
/// 서버 API: POST /auth/google/token, POST /auth/kakao/token
/// 요청 필드: { "token": "..." }
class OAuthTokenRequest {
  final String token;

  const OAuthTokenRequest({required this.token});

  Map<String, dynamic> toJson() => {'token': token};
}
