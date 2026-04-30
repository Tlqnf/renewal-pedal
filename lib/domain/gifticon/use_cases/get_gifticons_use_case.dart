import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class GetGifticonsUseCase {
  final GifticonRepository _repository;
  GetGifticonsUseCase(this._repository);

  Future<({Failure? failure, List<GifticonEntity>? data})> call() {
    return _repository.getGifticons();
  }
}
