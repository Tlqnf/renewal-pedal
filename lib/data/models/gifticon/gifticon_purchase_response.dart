import 'package:pedal/domain/gifticon/entities/gifticon_purchase_entity.dart';

class GifticonPurchaseResponse {
  final String id;
  final String gifticonId;
  final String status;
  final DateTime availableAt;
  final DateTime expiresAt;

  const GifticonPurchaseResponse({
    required this.id,
    required this.gifticonId,
    required this.status,
    required this.availableAt,
    required this.expiresAt,
  });

  factory GifticonPurchaseResponse.fromJson(Map<String, dynamic> json) =>
      GifticonPurchaseResponse(
        id: json['id'] as String,
        gifticonId: json['gifticon_id'] as String,
        status: json['status'] as String,
        availableAt: DateTime.parse(json['available_at'] as String),
        expiresAt: DateTime.parse(json['expires_at'] as String),
      );

  GifticonPurchaseEntity toEntity() => GifticonPurchaseEntity(
    id: id,
    gifticonId: gifticonId,
    status: status,
    availableAt: availableAt,
    expiresAt: expiresAt,
  );
}
