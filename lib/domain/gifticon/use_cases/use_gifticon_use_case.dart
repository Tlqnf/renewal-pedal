import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class UseGifticonUseCase {
  final GifticonRepository _repository;
  UseGifticonUseCase(this._repository);

  Future<({Failure? failure})> call(String userGifticonId) {
    return _repository.useGifticon(userGifticonId);
  }
}
