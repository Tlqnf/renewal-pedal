import 'package:pedal/domain/event/entities/event_detail_entity.dart';
import 'package:pedal/domain/event/entities/event_entity.dart';
import 'package:pedal/domain/event/entities/event_request_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class EventRepository {
  Future<({Failure? failure, List<EventEntity>? data})> getEvents();
  Future<({Failure? failure, EventDetailEntity? data})> getEventDetail(
    String eventId,
  );
  Future<({Failure? failure})> participateEvent(String eventId);
  Future<({Failure? failure})> submitEventRequest(EventRequestEntity request);
}
