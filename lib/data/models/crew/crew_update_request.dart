import 'dart:io';

import 'package:dio/dio.dart';

class CrewUpdateRequest {
  final String? name;
  final String? description;
  final List<String>? crewTypes;
  final String? location;
  final bool? isPublic;
  final File? coverImage;

  const CrewUpdateRequest({
    this.name,
    this.description,
    this.crewTypes,
    this.location,
    this.isPublic,
    this.coverImage,
  });

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (crewTypes != null && crewTypes!.isNotEmpty) {
      for (final type in crewTypes!) {
        if (!map.containsKey('crew_type')) {
          map['crew_type'] = [];
        }
        (map['crew_type'] as List).add(type);
      }
    }
    if (location != null) map['location'] = location;
    if (isPublic != null) map['is_public'] = isPublic;
    if (coverImage != null) {
      map['cover_image'] = await MultipartFile.fromFile(coverImage!.path);
    }
    return FormData.fromMap(map);
  }
}
