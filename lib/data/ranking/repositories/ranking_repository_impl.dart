import 'package:pedal/domain/ranking/entities/ranking_entity.dart';
import 'package:pedal/domain/ranking/repositories/ranking_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class RankingRepositoryImpl implements RankingRepository {
  @override
  Future<({Failure? failure, List<RankingEntity>? data})> getRanking(
    RankingTab tab,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final unit = switch (tab) {
      RankingTab.distance => 'km',
      RankingTab.streak => '일',
      RankingTab.duration => '분',
      RankingTab.calorie => 'kcal',
    };

    final values = switch (tab) {
      RankingTab.distance => [324.5, 298.0, 275.3, 240.1, 215.7],
      RankingTab.streak => [30.0, 28.0, 25.0, 21.0, 18.0],
      RankingTab.duration => [1440.0, 1320.0, 1200.0, 1080.0, 960.0],
      RankingTab.calorie => [8500.0, 7800.0, 7200.0, 6500.0, 5900.0],
    };

    final nicknames = ['페달킹', '자전거여왕', '라이딩마스터', '힐클라이머', '스프린터'];

    return (
      failure: null,
      data: List.generate(
        5,
        (i) => RankingEntity(
          userId: 'user_${i + 1}',
          nickname: nicknames[i],
          rank: i + 1,
          value: values[i],
          unit: unit,
        ),
      ),
    );
  }
}
