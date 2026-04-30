import 'package:pedal/data/models/gifticon/gifticon_response.dart';
import 'package:pedal/domain/gifticon/entities/my_gifticon_entity.dart';

class MyGifticonResponse {
  final String id;
  final String status;
  final DateTime createdAt;
  final DateTime availableAt;
  final DateTime expiresAt;
  final DateTime? usedAt;
  final GifticonResponse gifticon;

  const MyGifticonResponse({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.availableAt,
    required this.expiresAt,
    this.usedAt,
    required this.gifticon,
  });

  factory MyGifticonResponse.fromJson(Map<String, dynamic> json) =>
      MyGifticonResponse(
        id: json['id'] as String,
        status: json['status'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        availableAt: DateTime.parse(json['available_at'] as String),
        expiresAt: DateTime.parse(json['expires_at'] as String),
        usedAt: json['used_at'] == null
            ? null
            : DateTime.parse(json['used_at'] as String),
        gifticon: GifticonResponse.fromJson(
          json['gifticon'] as Map<String, dynamic>,
        ),
      );

  MyGifticonEntity toEntity() {
    final GifticonStatus gifticonStatus;
    switch (status) {
      case 'pending':
        gifticonStatus = GifticonStatus.pending;
        break;
      case 'available':
        gifticonStatus = GifticonStatus.available;
        break;
      case 'used':
        gifticonStatus = GifticonStatus.used;
        break;
      case 'expired':
        gifticonStatus = GifticonStatus.expired;
        break;
      default:
        gifticonStatus = GifticonStatus.pending;
    }
    return MyGifticonEntity(
      id: id,
      status: gifticonStatus,
      createdAt: createdAt,
      availableAt: availableAt,
      expiresAt: expiresAt,
      usedAt: usedAt,
      gifticon: gifticon.toEntity(),
    );
  }
}
