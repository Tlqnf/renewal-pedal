class PointTransactionEntity {
  final String id;
  final int amount;
  final String type;
  final String? reason;
  final String? relatedGifticonId;
  final DateTime createdAt;

  const PointTransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    this.reason,
    this.relatedGifticonId,
    required this.createdAt,
  });
}
