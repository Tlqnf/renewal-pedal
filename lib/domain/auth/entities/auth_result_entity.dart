class AuthResultEntity {
  final bool isNewUser;
  final String? signupToken;
  final String? accessToken;
  final String? refreshToken;
  final String? email;
  final String? nickname;

  const AuthResultEntity({
    required this.isNewUser,
    this.signupToken,
    this.accessToken,
    this.refreshToken,
    this.email,
    this.nickname,
  });
}
