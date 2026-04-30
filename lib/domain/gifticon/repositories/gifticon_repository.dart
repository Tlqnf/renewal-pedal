import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_purchase_entity.dart';
import 'package:pedal/domain/gifticon/entities/my_gifticon_entity.dart';
import 'package:pedal/domain/gifticon/entities/point_transaction_entity.dart';

abstract class GifticonRepository {
  Future<({Failure? failure, List<GifticonEntity>? data})> getGifticons();
  Future<({Failure? failure, GifticonEntity? data})> getGifticonById(
    String gifticonId,
  );
  Future<({Failure? failure, GifticonPurchaseEntity? data})> purchaseGifticon(
    String gifticonId,
  );
  Future<({Failure? failure, List<MyGifticonEntity>? data})> getMyGifticons();
  Future<({Failure? failure})> useGifticon(String userGifticonId);
  Future<({Failure? failure, List<PointTransactionEntity>? data})>
  getPointTransactions();
  Future<({Failure? failure, int? points})> addPoints(int amount);
  Future<({Failure? failure, int? points})> subtractPoints(int amount);
}
