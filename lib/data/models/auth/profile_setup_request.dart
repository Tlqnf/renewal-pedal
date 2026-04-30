import 'dart:io';
import 'package:dio/dio.dart';

class ProfileSetupRequest {
  final String nickname;
  final String? bio;
  final File? profileImage;

  const ProfileSetupRequest({
    required this.nickname,
    this.bio,
    this.profileImage,
  });

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{
      'nickname': nickname,
      if (bio != null) 'bio': bio,
      if (profileImage != null)
        'profile_image': await MultipartFile.fromFile(profileImage!.path),
    };
    return FormData.fromMap(map);
  }
}
