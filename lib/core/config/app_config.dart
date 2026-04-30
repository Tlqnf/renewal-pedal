import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl =>
      dotenv.env['SERVER_ADDRESS'] ?? 'http://172.30.1.26:9019/';

  /// true → Mock Repository 사용, false → 실제 서버 연동
  static const bool useMock = bool.fromEnvironment(
    'USE_MOCK',
    defaultValue: true,
  );
}
