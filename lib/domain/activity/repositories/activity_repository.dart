import 'package:dartz/dartz.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<ChallengeEntity>>> getChallenges();
  Future<Either<Failure, List<CrewEntity>>> getRecommendedCrews();
  Future<Either<Failure, ActivityStatsEntity>> getActivityStats();
  Future<({Failure? failure, ChallengeDetailEntity? data})> getChallengeDetail(String challengeId);
  Future<({Failure? failure, List<ChallengeRankingEntity>? data})> getChallengeRanking(String challengeId);
  Future<({Failure? failure})> participateChallenge(String challengeId);
}
