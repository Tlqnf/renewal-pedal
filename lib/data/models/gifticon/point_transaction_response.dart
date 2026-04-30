import 'package:pedal/domain/gifticon/entities/point_transaction_entity.dart';

class PointTransactionResponse {
  final String id;
  final int amount;
  final String type;
  final String? reason;
  final String? relatedGifticonId;
  final DateTime createdAt;

  const PointTransactionResponse({
    required this.id,
    required this.amount,
    required this.type,
    this.reason,
    this.relatedGifticonId,
    required this.createdAt,
  });

  factory PointTransactionResponse.fromJson(Map<String, dynamic> json) =>
      PointTransactionResponse(
        id: json['id'] as String,
        amount: json['amount'] as int,
        type: json['type'] as String,
        reason: json['reason'] as String?,
        relatedGifticonId: json['related_gifticon_id'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  PointTransactionEntity toEntity() => PointTransactionEntity(
    id: id,
    amount: amount,
    type: type,
    reason: reason,
    relatedGifticonId: relatedGifticonId,
    createdAt: createdAt,
  );
}
