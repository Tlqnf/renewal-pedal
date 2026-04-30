import 'dart:io';

import 'package:dio/dio.dart';

class CrewPostCreateRequest {
  final String title;
  final String? content;
  final String? rideId;
  final List<File> files;

  const CrewPostCreateRequest({
    required this.title,
    this.content,
    this.rideId,
    this.files = const [],
  });

  Future<FormData> toFormData() async {
    final multipartFiles = await Future.wait(
      files.map((f) => MultipartFile.fromFile(f.path)),
    );
    return FormData.fromMap({
      'title': title,
      if (content != null) 'content': content,
      if (rideId != null) 'ride_id': rideId,
      'files': multipartFiles,
    });
  }
}
