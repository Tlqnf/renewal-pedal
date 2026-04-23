import 'package:dartz/dartz.dart';
import 'package:pedal/domain/auth/entities/user_entity.dart';
import 'package:pedal/domain/failures/failures.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class GetMeUseCase {
  final AuthRepository _repository;

  GetMeUseCase(this._repository);

  Future<Either<Failure, UserEntity>> execute() {
    return _repository.getMe();
  }
}
