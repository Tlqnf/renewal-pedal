import 'package:pedal/data/api/failure_mapper.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pedal/data/event/sources/event_remote_source.dart';
import 'package:pedal/domain/event/entities/event_detail_entity.dart';
import 'package:pedal/domain/event/entities/event_entity.dart';
import 'package:pedal/domain/event/entities/event_request_entity.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteSource _remoteSource;

  EventRepositoryImpl(this._remoteSource);

  @override
  Future<({Failure? failure, List<EventEntity>? data})> getEvents() async {
    try {
      final responses = await _remoteSource.getEvents();
      return (failure: null, data: responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, EventDetailEntity? data})> getEventDetail(
    String eventId,
  ) async {
    try {
      final response = await _remoteSource.getEventById(eventId);
      final entity = EventDetailEntity(
        id: response.id,
        title: response.title,
        bannerImageUrl: response.imageUrl,
        participationRestriction: '',
        startDate: response.startsAt ?? DateTime.now(),
        endDate: response.endsAt ?? DateTime.now(),
        description: response.description,
        steps: const [],
      );
      return (failure: null, data: entity);
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure})> participateEvent(String eventId) async {
    try {
      await _remoteSource.joinEvent(eventId);
      return (failure: null);
    } on DioException catch (e) {
      return (failure: mapDioException(e));
    } catch (_) {
      return (failure: const UnknownFailure());
    }
  }

  @override
  Future<({Failure? failure})> submitEventRequest(
    EventRequestEntity request,
  ) async {
    try {
      final image = File(request.imagePath);
      await _remoteSource.submitEvent(request.eventId, image, request.memo);
      return (failure: null);
    } on DioException catch (e) {
      return (failure: mapDioException(e));
    } catch (_) {
      return (failure: const UnknownFailure());
    }
  }
}
