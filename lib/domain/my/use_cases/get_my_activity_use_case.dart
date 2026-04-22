import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetMyActivityUseCase {
  final MyRepository _repository;
  GetMyActivityUseCase(this._repository);

  Future<({
    Failure? failure,
    List<ChallengeEntity>? challenges,
    List<CrewEntity>? crews,
    List<SavedRouteEntity>? routes,
  })> call() async {
    final c = await _repository.getParticipatedChallenges();
    if (c.failure != null) return (failure: c.failure, challenges: null, crews: null, routes: null);
    final cr = await _repository.getParticipatedCrews();
    if (cr.failure != null) return (failure: cr.failure, challenges: c.data, crews: null, routes: null);
    final r = await _repository.getSavedRoutes();
    return (failure: r.failure, challenges: c.data, crews: cr.data, routes: r.data);
  }
}
