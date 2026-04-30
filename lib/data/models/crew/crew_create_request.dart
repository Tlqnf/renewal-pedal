import 'dart:io';

import 'package:dio/dio.dart';

class CrewCreateRequest {
  final String name;
  final String location;
  final List<String> crewTypes;
  final String? description;
  final bool isPublic;
  final File? coverImage;

  const CrewCreateRequest({
    required this.name,
    required this.location,
    required this.crewTypes,
    this.description,
    this.isPublic = true,
    this.coverImage,
  });

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{
      'name': name,
      'location': location,
      'is_public': isPublic,
    };

    // crew_type을 배열로 전송
    for (final type in crewTypes) {
      if (!map.containsKey('crew_type')) {
        map['crew_type'] = [];
      }
      (map['crew_type'] as List).add(type);
    }

    if (description != null) map['description'] = description;
    if (coverImage != null) {
      map['cover_image'] = await MultipartFile.fromFile(coverImage!.path);
    }
    return FormData.fromMap(map);
  }
}
