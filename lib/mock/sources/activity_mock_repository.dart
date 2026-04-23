import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/mock/data/activity_mock_data.dart';
import 'package:pedal/mock/data/activity_challenge_detail_mock_data.dart';

class ActivityMockRepository implements ActivityRepository {
  @override
  Future<Either<Failure, List<ChallengeEntity>>> getChallenges() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(ActivityMockData.challenges);
  }

  @override
  Future<Either<Failure, List<CrewEntity>>> getRecommendedCrews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return Right(ActivityMockData.recommendedCrews);
  }

  @override
  Future<Either<Failure, ActivityStatsEntity>> getActivityStats() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Right(ActivityMockData.stats);
  }

  @override
  Future<({Failure? failure, ChallengeDetailEntity? data})> getChallengeDetail(
    String challengeId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return (
      failure: null,
      data: ActivityChallengeDetailMockData.challengeDetail,
    );
  }

  @override
  Future<({Failure? failure, List<ChallengeRankingEntity>? data})>
  getChallengeRanking(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null, data: ActivityChallengeDetailMockData.rankingList);
  }

  @override
  Future<({Failure? failure})> participateChallenge(String challengeId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (failure: null);
  }
}
