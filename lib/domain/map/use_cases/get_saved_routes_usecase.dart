import 'package:dartz/dartz.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/map_repository.dart';

class GetSavedRoutesUseCase {
  final MapRepository _repository;

  GetSavedRoutesUseCase(this._repository);

  Future<Either<Failure, List<RouteEntity>>> execute({String? search}) async {
    return _repository.getSavedRoutes(search: search);
  }
}
