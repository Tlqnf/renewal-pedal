import 'package:pedal/data/api/failure_mapper.dart';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pedal/data/models/auth/login_request.dart';
import 'package:pedal/data/models/auth/login_response.dart';
import 'package:pedal/data/models/auth/profile_setup_request.dart';
import 'package:pedal/data/auth/sources/auth_remote_source.dart';
import 'package:pedal/data/sources/secure_storage.dart';
import 'package:pedal/domain/auth/entities/auth_result_entity.dart';
import 'package:pedal/domain/auth/entities/user_entity.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._remoteSource, this._secureStorage);

  /// 로그인 성공 후 토큰 저장 + 기존 사용자인 경우 user_id 저장
  Future<void> _saveLoginResult(OAuthLoginResponse response) async {
    if (response.accessToken != null && response.refreshToken != null) {
      await _secureStorage.saveTokens(
        accessToken: response.accessToken!,
        refreshToken: response.refreshToken!,
      );
      // 기존 사용자만 user_id 저장 (신규는 setupProfile 완료 후 저장)
      if (!response.isNewUser) {
        final meResponse = await _remoteSource.getMe();
        await _secureStorage.saveUserId(meResponse.id);
      }
    }
  }

  @override
  Future<Either<Failure, AuthResultEntity>> loginWithGoogle(
    String idToken,
  ) async {
    try {
      final response = await _remoteSource.loginWithGoogle(
        OAuthTokenRequest(token: idToken),
      );
      await _saveLoginResult(response);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResultEntity>> loginWithKakao(
    String accessToken,
  ) async {
    try {
      final response = await _remoteSource.loginWithKakao(
        OAuthTokenRequest(token: accessToken),
      );
      await _saveLoginResult(response);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResultEntity>> loginWithNaver(
    String accessToken,
  ) async {
    try {
      final response = await _remoteSource.loginWithNaver(
        OAuthTokenRequest(token: accessToken),
      );
      await _saveLoginResult(response);
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setupProfile({
    required String signupToken,
    required String nickname,
    String? bio,
    File? profileImage,
  }) async {
    try {
      final response = await _remoteSource.setupProfile(
        ProfileSetupRequest(
          nickname: nickname,
          bio: bio,
          profileImage: profileImage,
        ),
        signupToken,
      );
      await _secureStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      // 프로필 설정 완료 = 실질적 첫 로그인, user_id 저장
      final meResponse = await _remoteSource.getMe();
      await _secureStorage.saveUserId(meResponse.id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _remoteSource.deleteAccount();
      await _secureStorage.deleteAll();
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final response = await _remoteSource.getMe();
      return Right(response.toEntity());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<String?> getCachedAccessToken() => _secureStorage.readAccessToken();

  @override
  Future<String?> getCachedUserId() => _secureStorage.readUserId();

  @override
  Future<void> clearTokens() => _secureStorage.deleteAll();
}
