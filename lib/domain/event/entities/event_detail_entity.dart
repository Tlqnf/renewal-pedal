import 'package:pedal/domain/event/entities/event_step_entity.dart';

class EventDetailEntity {
  final String id;
  final String title;
  final String bannerImageUrl;
  final String participationRestriction;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final List<EventStepEntity> steps;

  const EventDetailEntity({
    required this.id,
    required this.title,
    required this.bannerImageUrl,
    required this.participationRestriction,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.steps,
  });
}
