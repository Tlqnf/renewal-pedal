import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';

class NaverSignInService {
  Future<String?> getAccessToken() async {
    try {
      final result = await FlutterNaverLogin.logIn();
      if (result.status == NaverLoginStatus.loggedIn) {
        final token = await FlutterNaverLogin.getCurrentAccessToken();
        return token.accessToken;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await FlutterNaverLogin.logOut();
    } catch (_) {}
  }
}
