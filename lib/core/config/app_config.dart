class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'SERVER_ADDRESS',
    defaultValue: 'http://172.30.1.33:8000/', // Android 에뮬레이터 localhost
  );
}