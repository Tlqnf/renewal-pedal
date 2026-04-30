import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';

enum GifticonStatus { pending, available, used, expired }

class MyGifticonEntity {
  final String id;
  final GifticonStatus status;
  final DateTime createdAt;
  final DateTime availableAt;
  final DateTime expiresAt;
  final DateTime? usedAt;
  final GifticonEntity gifticon;

  const MyGifticonEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.availableAt,
    required this.expiresAt,
    this.usedAt,
    required this.gifticon,
  });
}
