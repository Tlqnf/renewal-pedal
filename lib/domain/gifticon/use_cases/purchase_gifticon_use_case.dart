import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_purchase_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class PurchaseGifticonUseCase {
  final GifticonRepository _repository;
  PurchaseGifticonUseCase(this._repository);

  Future<({Failure? failure, GifticonPurchaseEntity? data})> call(
    String gifticonId,
  ) {
    return _repository.purchaseGifticon(gifticonId);
  }
}
