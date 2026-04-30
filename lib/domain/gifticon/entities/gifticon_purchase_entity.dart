class GifticonPurchaseEntity {
  final String id;
  final String gifticonId;
  final String status;
  final DateTime availableAt;
  final DateTime expiresAt;

  const GifticonPurchaseEntity({
    required this.id,
    required this.gifticonId,
    required this.status,
    required this.availableAt,
    required this.expiresAt,
  });
}
