import 'package:dartz/dartz.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetSavedRoutesUseCase {
  final MyRepository _repository;

  GetSavedRoutesUseCase(this._repository);

  Future<Either<Failure, List<SavedRouteEntity>>> execute() async {
    final result = await _repository.getSavedRoutes();
    if (result.failure != null) {
      return Left(result.failure!);
    }
    return Right(result.data ?? []);
  }
}
