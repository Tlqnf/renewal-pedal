import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetMyActivityUseCase {
  final MyRepository _repository;
  GetMyActivityUseCase(this._repository);

  Future<
    ({
      Failure? failure,
      List<CrewEntity>? crews,
      List<SavedRouteEntity>? routes,
    })
  >
  call() async {
    final cr = await _repository.getParticipatedCrews();
    if (cr.failure != null) {
      return (failure: cr.failure, crews: null, routes: null);
    }
    final r = await _repository.getSavedRoutes();
    return (failure: r.failure, crews: cr.data, routes: r.data);
  }
}
