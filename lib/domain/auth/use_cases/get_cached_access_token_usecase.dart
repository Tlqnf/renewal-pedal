import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class GetCachedAccessTokenUseCase {
  final AuthRepository _repository;
  GetCachedAccessTokenUseCase(this._repository);

  Future<String?> execute() => _repository.getCachedAccessToken();
}
