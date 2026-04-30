import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/map/sources/map_remote_source.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteSource _remoteSource;

  MapRepositoryImpl(this._remoteSource);

  @override
  Future<Either<Failure, List<RouteEntity>>> getSavedRoutes({
    String? search,
  }) async {
    try {
      final responses = await _remoteSource.getSavedRoutes(search: search);
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<RouteEntity>>> aiRecommendRoute(
    Map<String, dynamic> params,
  ) async {
    try {
      final responses = await _remoteSource.aiRecommendRoute(params);
      return Right(responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }
}
