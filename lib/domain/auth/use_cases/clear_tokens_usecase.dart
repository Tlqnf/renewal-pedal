import 'package:pedal/domain/auth/repositories/auth_repository.dart';

class ClearTokensUseCase {
  final AuthRepository _repository;
  ClearTokensUseCase(this._repository);

  Future<void> execute() => _repository.clearTokens();
}
