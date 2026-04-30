import 'package:pedal/data/api/failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/gifticon/sources/gifticon_remote_source.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_entity.dart';
import 'package:pedal/domain/gifticon/entities/gifticon_purchase_entity.dart';
import 'package:pedal/domain/gifticon/entities/my_gifticon_entity.dart';
import 'package:pedal/domain/gifticon/entities/point_transaction_entity.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

class GifticonRepositoryImpl implements GifticonRepository {
  final GifticonRemoteSource _remoteSource;

  GifticonRepositoryImpl(this._remoteSource);

  @override
  Future<({Failure? failure, List<GifticonEntity>? data})>
  getGifticons() async {
    try {
      final responses = await _remoteSource.getGifticons();
      return (failure: null, data: responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, GifticonEntity? data})> getGifticonById(
    String gifticonId,
  ) async {
    try {
      final response = await _remoteSource.getGifticonById(gifticonId);
      return (failure: null, data: response.toEntity());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, GifticonPurchaseEntity? data})> purchaseGifticon(
    String gifticonId,
  ) async {
    try {
      final response = await _remoteSource.purchaseGifticon(gifticonId);
      return (failure: null, data: response.toEntity());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, List<MyGifticonEntity>? data})>
  getMyGifticons() async {
    try {
      final responses = await _remoteSource.getMyGifticons();
      return (failure: null, data: responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure})> useGifticon(String userGifticonId) async {
    try {
      await _remoteSource.useGifticon(userGifticonId);
      return (failure: null);
    } on DioException catch (e) {
      return (failure: mapDioException(e));
    } catch (_) {
      return (failure: const UnknownFailure());
    }
  }

  @override
  Future<({Failure? failure, List<PointTransactionEntity>? data})>
  getPointTransactions() async {
    try {
      final responses = await _remoteSource.getPointTransactions();
      return (failure: null, data: responses.map((e) => e.toEntity()).toList());
    } on DioException catch (e) {
      return (failure: mapDioException(e), data: null);
    } catch (_) {
      return (failure: const UnknownFailure(), data: null);
    }
  }

  @override
  Future<({Failure? failure, int? points})> addPoints(int amount) async {
    try {
      final points = await _remoteSource.addPoints(amount);
      return (failure: null, points: points);
    } on DioException catch (e) {
      return (failure: mapDioException(e), points: null);
    } catch (_) {
      return (failure: const UnknownFailure(), points: null);
    }
  }

  @override
  Future<({Failure? failure, int? points})> subtractPoints(int amount) async {
    try {
      final points = await _remoteSource.subtractPoints(amount);
      return (failure: null, points: points);
    } on DioException catch (e) {
      return (failure: mapDioException(e), points: null);
    } catch (_) {
      return (failure: const UnknownFailure(), points: null);
    }
  }
}
