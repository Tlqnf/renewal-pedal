abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// 서버 에러 (4xx, 5xx)
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});
}

/// 네트워크 에러 (연결 실패, 타임아웃)
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '네트워크 연결을 확인해주세요']);
}

/// 입력 검증 에러 (UseCase에서 사용)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// 인증 에러 (토큰 만료 등)
class AuthFailure extends Failure {
  const AuthFailure([super.message = '다시 로그인해주세요']);
}

/// 알 수 없는 에러
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '오류가 발생했습니다']);
}
