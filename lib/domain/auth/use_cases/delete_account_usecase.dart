// ============================================================
// FILE: delete_account_usecase.dart
// LAYER: domain
// RESPONSIBILITY: 회원탈퇴 UseCase (DELETE /auth/account)
// DEPENDENCIES: AuthRepository, Failure
// ============================================================

import 'package:dartz/dartz.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, void>> execute() {
    return _repository.deleteAccount();
  }
}
