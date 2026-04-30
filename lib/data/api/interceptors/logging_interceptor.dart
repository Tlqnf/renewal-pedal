import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[API REQUEST] ${options.method} ${options.uri}');
    debugPrint('[API REQUEST] Headers: ${options.headers}');
    debugPrint('[API REQUEST] Body: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '[API RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
    );
    debugPrint('[API RESPONSE] Body: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '[API ERROR] ${err.response?.statusCode} ${err.requestOptions.uri}',
    );
    debugPrint('[API ERROR] Message: ${err.message}');
    debugPrint('[API ERROR] Body: ${err.response?.data}');
    handler.next(err);
  }
}
