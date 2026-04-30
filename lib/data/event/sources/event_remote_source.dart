import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/event/event_participant_response.dart';
import 'package:pedal/data/models/event/event_response.dart';

class EventRemoteSource {
  final DioClient _client;

  EventRemoteSource(this._client);

  Future<List<EventResponse>> getEvents() async {
    final response = await _client.get('/events');
    debugPrint('[EventRemoteSource] GET /events 응답: ${response.statusCode}');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => EventResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<EventResponse> getEventById(String eventId) async {
    final response = await _client.get('/events/$eventId');
    debugPrint(
      '[EventRemoteSource] GET /events/$eventId 응답: ${response.statusCode}',
    );
    return EventResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> joinEvent(String eventId) async {
    await _client.post('/events/$eventId/join');
    debugPrint('[EventRemoteSource] POST /events/$eventId/join 완료');
  }

  Future<void> submitEvent(String eventId, File image, String? memo) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
      if (memo != null && memo.isNotEmpty) 'memo': memo,
    });
    await _client.post(
      '/events/$eventId/submit',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    debugPrint('[EventRemoteSource] POST /events/$eventId/submit 완료');
  }

  Future<List<EventParticipantResponse>> getEventParticipants(
    String eventId,
  ) async {
    final response = await _client.get('/events/$eventId/participants');
    debugPrint(
      '[EventRemoteSource] GET /events/$eventId/participants 응답: ${response.statusCode}',
    );
    final list = response.data as List<dynamic>;
    return list
        .map(
          (item) =>
              EventParticipantResponse.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
