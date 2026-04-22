import 'package:pedal/domain/ranking/entities/ranking_entity.dart';
import 'package:pedal/domain/ranking/repositories/ranking_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetRankingUseCase {
  final RankingRepository _repository;
  GetRankingUseCase(this._repository);

  Future<({Failure? failure, List<RankingEntity>? data})> call(RankingTab tab) {
    return _repository.getRanking(tab);
  }
}
