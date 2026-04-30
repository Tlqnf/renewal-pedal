import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/activity/sources/crew_remote_source.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/domain/activity/repositories/crew_detail_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class CrewDetailRepositoryImpl implements CrewDetailRepository {
  final CrewRemoteSource _remoteSource;

  CrewDetailRepositoryImpl(this._remoteSource);

  @override
  Future<Either<Failure, CrewDetailEntity>> getCrewDetail(String crewId) async {
    try {
      final response = await _remoteSource.getCrewById(crewId);
      final members = await _remoteSource.getCrewMembers(crewId);
      final memberRankings = members.asMap().entries.map((e) {
        final m = e.value.toEntity();
        return CrewMemberRankingEntity(
          userId: m.id,
          nickname: m.username,
          profileImageUrl: m.avatarUrl.isEmpty ? null : m.avatarUrl,
          rank: e.key + 1,
          distanceKm: 0,
        );
      }).toList();

      final entity = CrewDetailEntity(
        id: response.id,
        name: response.name,
        coverImageUrl: response.imageUrl.isEmpty ? null : response.imageUrl,
        location: response.location,
        hashtags: response.crewTypes,
        description: response.description ?? '',
        memberCount: response.memberCount,
        crewPoint: 0,
        memberRankings: memberRankings,
      );
      return Right(entity);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> joinCrew(String crewId) async {
    try {
      await _remoteSource.joinCrew(crewId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
