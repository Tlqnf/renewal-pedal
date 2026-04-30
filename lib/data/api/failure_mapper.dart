import 'package:dio/dio.dart';
import 'package:pedal/domain/failures/failures.dart';

ServerFailure mapDioException(DioException e) {
  final statusCode = e.response?.statusCode;
  final message = switch (statusCode) {
    400 => '잘못된 요청입니다',
    401 => '로그인이 필요합니다',
    403 => '권한이 없습니다',
    404 => '데이터를 찾을 수 없습니다',
    422 => _parse422Message(e.response?.data),
    500 => '서버 오류가 발생했습니다',
    _ => '알 수 없는 오류가 발생했습니다',
  };
  return ServerFailure(message, statusCode: statusCode);
}

String _parse422Message(dynamic data) {
  try {
    final detail = data['detail'] as List;
    return detail.map((e) => e['msg']).join(', ');
  } catch (_) {
    return '입력값을 확인해주세요';
  }
}
