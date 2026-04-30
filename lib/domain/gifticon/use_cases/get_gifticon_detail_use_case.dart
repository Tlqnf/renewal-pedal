import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class GetGifticonDetailUseCase {
  final GifticonRepository _repository;
  GetGifticonDetailUseCase(this._repository);

  Future<({Failure? failure, GifticonEntity? data})> call(String gifticonId) {
    return _repository.getGifticonById(gifticonId);
  }
}
