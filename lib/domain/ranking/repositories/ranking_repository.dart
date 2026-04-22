import 'package:pedal/domain/ranking/entities/ranking_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class RankingRepository {
  Future<({Failure? failure, List<RankingEntity>? data})> getRanking(RankingTab tab);
}
