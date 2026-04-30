class ProfileSetupResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  const ProfileSetupResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'bearer',
  });

  factory ProfileSetupResponse.fromJson(Map<String, dynamic> json) {
    return ProfileSetupResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }
}
