import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetMyProfileUseCase {
  final MyRepository _repository;
  GetMyProfileUseCase(this._repository);

  Future<({Failure? failure, MyProfileEntity? data})> call() {
    return _repository.getMyProfile();
  }
}
