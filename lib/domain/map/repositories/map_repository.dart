import 'package:dartz/dartz.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class MapRepository {
  // GET /map/saved
  Future<Either<Failure, List<RouteEntity>>> getSavedRoutes({String? search});

  // POST /map/ai-recommend
  Future<Either<Failure, List<RouteEntity>>> aiRecommendRoute(
    Map<String, dynamic> params,
  );
}
