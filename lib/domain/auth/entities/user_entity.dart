class UserEntity {
  final String id;
  final String username;
  final String avatarUrl;
  final String? bio;

  UserEntity({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.bio,
  });
}
