import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/activity/sources/crew_remote_source.dart';
import 'package:pedal/domain/activity/entities/activity_stats_entity.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final CrewRemoteSource _crewRemoteSource;

  ActivityRepositoryImpl(this._crewRemoteSource);

  @override
  Future<Either<Failure, List<CrewEntity>>> getRecommendedCrews() async {
    try {
      final responses = await _crewRemoteSource.getRecommendCrews();
      return Right(responses.map((r) => r.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, ActivityStatsEntity>> getActivityStats() async {
    return const Right(
      ActivityStatsEntity(
        officialCount: 0,
        unofficialCount: 0,
        totalParticipants: 0,
      ),
    );
  }
}
