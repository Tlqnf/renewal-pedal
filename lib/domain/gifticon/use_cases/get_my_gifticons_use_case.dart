import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/my_gifticon_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class GetMyGifticonsUseCase {
  final GifticonRepository _repository;
  GetMyGifticonsUseCase(this._repository);

  Future<({Failure? failure, List<MyGifticonEntity>? data})> call() {
    return _repository.getMyGifticons();
  }
}
