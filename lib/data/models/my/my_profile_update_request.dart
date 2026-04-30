import 'dart:io';
import 'package:dio/dio.dart';

class MyProfileUpdateRequest {
  final String? nickname;
  final String? bio;
  final File? profileImage;

  const MyProfileUpdateRequest({this.nickname, this.bio, this.profileImage});

  Future<FormData> toFormData() async {
    final fields = <MapEntry<String, dynamic>>[];

    if (nickname != null) {
      fields.add(MapEntry('nickname', nickname));
    }
    if (bio != null) {
      fields.add(MapEntry('bio', bio));
    }

    final formData = FormData.fromMap(Map.fromEntries(fields));

    if (profileImage != null) {
      formData.files.add(
        MapEntry(
          'profile_image',
          await MultipartFile.fromFile(
            profileImage!.path,
            filename: profileImage!.path.split('/').last,
          ),
        ),
      );
    }

    return formData;
  }
}
