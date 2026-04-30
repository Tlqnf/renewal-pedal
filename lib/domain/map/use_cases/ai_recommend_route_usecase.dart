import 'package:dartz/dartz.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/map_repository.dart';

class AiRecommendRouteUseCase {
  final MapRepository _repository;

  AiRecommendRouteUseCase(this._repository);

  Future<Either<Failure, List<RouteEntity>>> execute(
    Map<String, dynamic> params,
  ) async {
    return _repository.aiRecommendRoute(params);
  }
}
