import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class GetMyFeedUseCase {
  final FeedRepository _repository;

  GetMyFeedUseCase(this._repository);

  Future<Either<Failure, List<FeedEntity>>> execute({
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.getMyFeed(limit: limit, offset: offset);
  }
}
