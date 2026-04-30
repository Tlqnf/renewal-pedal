import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';

class CreateFeedUseCase {
  final FeedRepository _repository;

  CreateFeedUseCase(this._repository);

  Future<Either<Failure, void>> execute({
    required String title,
    String? content,
    String? rideId,
    List<File> files = const [],
  }) {
    if (title.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('제목을 입력해주세요')));
    }
    return _repository.createFeed(
      title: title.trim(),
      content: content,
      rideId: rideId,
      files: files,
    );
  }
}
