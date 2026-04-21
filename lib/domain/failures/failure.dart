// ============================================================
// FILE: failure.dart
// LAYER: domain
// RESPONSIBILITY: 에러 타입 정의 (Result 패턴)
// DEPENDENCIES: None
// ============================================================

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = '서버 오류가 발생했습니다']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '네트워크 연결을 확인해주세요']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = '로컬 저장소 오류가 발생했습니다']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = '입력값이 올바르지 않습니다']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '알 수 없는 오류가 발생했습니다']);
}
