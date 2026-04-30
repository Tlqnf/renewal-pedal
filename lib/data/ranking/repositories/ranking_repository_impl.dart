import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/ranking/sources/ranking_remote_source.dart';
import 'package:pedal/domain/ranking/entities/ranking_entity.dart';
import 'package:pedal/domain/ranking/repositories/ranking_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class RankingRepositoryImpl implements RankingRepository {
  final RankingRemoteSource? _remoteSource;

  RankingRepositoryImpl([this._remoteSource]);

  static const _tabToType = {
    RankingTab.distance: 'distance',
    RankingTab.streak: 'streak',
    RankingTab.duration: 'time',
    RankingTab.calorie: 'calories',
  };

  @override
  Future<({Failure? failure, List<RankingEntity>? data})> getRanking(
    RankingTab tab,
  ) async {
    if (_remoteSource == null) {
      return _getMockRanking(tab);
    }

    try {
      final rankingType = _tabToType[tab]!;
      final response = await _remoteSource.getRanking(rankingType);
      return (
        failure: null,
        data: response.top10.map((e) => e.toEntity()).toList(),
      );
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  ({Failure? failure, List<RankingEntity>? data}) _getMockRanking(
    RankingTab tab,
  ) {
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
