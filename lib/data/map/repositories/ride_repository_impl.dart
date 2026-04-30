import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/models/ride/finish_ride_request.dart';
import 'package:pedal/data/models/ride/ride_point_in.dart';
import 'package:pedal/data/map/sources/ride_remote_source.dart';
import 'package:pedal/domain/map/entities/ride_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/map/repositories/ride_repository.dart';

class RideRepositoryImpl implements RideRepository {
  final RideRemoteSource _remoteSource;

  RideRepositoryImpl(this._remoteSource);

  @override
  Future<Either<Failure, RideEntity>> finishRide({
    required String? title,
    required DateTime startedAt,
    required DateTime endedAt,
    required int distanceM,
    required int durationSec,
    required int? caloriesKcal,
    required String visibility,
    required List<Map<String, double>> points,
    required bool saveAsRoute,
    required String? routeName,
  }) async {
    try {
      final request = FinishRideRequest(
        title: title,
        startedAt: startedAt,
        endedAt: endedAt,
        distanceM: distanceM,
        durationSec: durationSec,
        caloriesKcal: caloriesKcal,
        visibility: visibility,
        points: points
            .map((p) => RidePointIn(lat: p['lat']!, lng: p['lng']!))
            .toList(),
        saveAsRoute: saveAsRoute,
        routeName: routeName,
      );
      final response = await _remoteSource.finishRide(request);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<List<double>>>> getRideTrack(
    String rideId,
  ) async {
    try {
      final response = await _remoteSource.getRideTrack(rideId);
      return Right(response.decodePolyline());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, RideEntity>> getRide(String rideId) async {
    try {
      final response = await _remoteSource.getRide(rideId);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRide(String rideId) async {
    try {
      await _remoteSource.deleteRide(rideId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }
}
