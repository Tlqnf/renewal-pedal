import 'package:dartz/dartz.dart';
import 'package:pedal/domain/auth/entities/auth_result_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository _repository;

  GoogleLoginUseCase(this._repository);

  Future<Either<Failure, AuthResultEntity>> execute(String idToken) {
    if (idToken.isEmpty) {
      return Future.value(const Left(ValidationFailure('Google 인증 토큰이 없습니다')));
    }
    return _repository.loginWithGoogle(idToken);
  }
}

class KakaoLoginUseCase {
  final AuthRepository _repository;

  KakaoLoginUseCase(this._repository);

  Future<Either<Failure, AuthResultEntity>> execute(String accessToken) {
    if (accessToken.isEmpty) {
      return Future.value(const Left(ValidationFailure('카카오 액세스 토큰이 없습니다')));
    }
    return _repository.loginWithKakao(accessToken);
  }
}

class NaverLoginUseCase {
  final AuthRepository _repository;

  NaverLoginUseCase(this._repository);

  Future<Either<Failure, AuthResultEntity>> execute(String accessToken) {
    if (accessToken.isEmpty) {
      return Future.value(const Left(ValidationFailure('네이버 액세스 토큰이 없습니다')));
    }
    return _repository.loginWithNaver(accessToken);
  }
}
