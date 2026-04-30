import 'package:pedal/domain/event/entities/event_entity.dart';

class EventResponse {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final DateTime? startsAt;
  final DateTime? endsAt;

  const EventResponse({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.startsAt,
    this.endsAt,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      id: json['id'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      startsAt: json['starts_at'] != null
          ? DateTime.tryParse(json['starts_at'] as String)
          : null,
      endsAt: json['ends_at'] != null
          ? DateTime.tryParse(json['ends_at'] as String)
          : null,
    );
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      title: title,
      subtitle: description,
      imageUrls: imageUrl.isNotEmpty ? [imageUrl] : [],
    );
  }
}
