// ============================================================
// FILE: setup_profile_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 초기 프로필 설정 UseCase (닉네임 검증 + Repository 호출)
// DEPENDENCIES: AuthRepository, Failure
// ============================================================

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class SetupProfileUseCase {
  final AuthRepository _repository;

  SetupProfileUseCase(this._repository);

  Future<Either<Failure, void>> execute({
    required String signupToken,
    required String nickname,
    String? bio,
    File? profileImage,
  }) {
    if (nickname.trim().length < 2 || nickname.trim().length > 40) {
      return Future.value(
        const Left(ValidationFailure('닉네임은 2자 이상 40자 이하여야 합니다')),
      );
    }
    return _repository.setupProfile(
      signupToken: signupToken,
      nickname: nickname.trim(),
      bio: bio,
      profileImage: profileImage,
    );
  }
}
