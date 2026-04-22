import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pedal/domain/auth/entities/auth_result_entity.dart';
import 'package:pedal/domain/auth/entities/user_entity.dart';
import 'package:pedal/domain/failures/failures.dart';

abstract class AuthRepository {
  // POST /auth/google/token
  Future<Either<Failure, AuthResultEntity>> loginWithGoogle(String idToken);

  // POST /auth/kakao/token
  Future<Either<Failure, AuthResultEntity>> loginWithKakao(String accessToken);

  // POST /auth/naver/token
  Future<Either<Failure, AuthResultEntity>> loginWithNaver(String accessToken);

  // POST /auth/profile/setup (Authorization: Bearer signup_token)
  Future<Either<Failure, void>> setupProfile({
    required String signupToken,
    required String nickname,
    String? bio,
    File? profileImage,
  });

  // DELETE /auth/account
  Future<Either<Failure, void>> deleteAccount();

  // GET /auth/me
  Future<Either<Failure, UserEntity>> getMe();

  // SecureStorage에서 access_token 읽기 (자동 로그인용)
  Future<String?> getCachedAccessToken();

  // SecureStorage에서 user_id 읽기
  Future<String?> getCachedUserId();

  // 저장된 토큰 전체 삭제 (로그아웃)
  Future<void> clearTokens();
}
