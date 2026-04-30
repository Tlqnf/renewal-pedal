import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class GetUserFeedUseCase {
  final FeedRepository _repository;

  GetUserFeedUseCase(this._repository);

  Future<Either<Failure, List<FeedEntity>>> execute(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.getUserFeed(userId, limit: limit, offset: offset);
  }
}
