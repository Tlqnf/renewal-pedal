import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class GetCachedUserIdUseCase {
  final AuthRepository _repository;
  GetCachedUserIdUseCase(this._repository);

  Future<String?> execute() => _repository.getCachedUserId();
}
