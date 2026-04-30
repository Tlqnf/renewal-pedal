// MOCK START - UI 테스트용. 실제 서버 연동 시 이 파일 및 DI의 MOCK 블록 제거
import 'package:pedal/data/auth/sources/auth_remote_source.dart';
import 'package:pedal/data/models/auth/login_request.dart';
import 'package:pedal/data/models/auth/login_response.dart';
import 'package:pedal/data/models/auth/me_response.dart';
import 'package:pedal/data/models/auth/profile_setup_request.dart';
import 'package:pedal/data/models/auth/profile_setup_response.dart';

class AuthMockRemoteSource implements AuthRemoteSource {
  static const _mockAccessToken = 'mock_access_token';
  static const _mockRefreshToken = 'mock_refresh_token';

  OAuthLoginResponse get _mockLoginResponse => const OAuthLoginResponse(
    isNewUser: false,
    accessToken: _mockAccessToken,
    refreshToken: _mockRefreshToken,
    tokenType: 'bearer',
  );

  @override
  Future<OAuthLoginResponse> loginWithGoogle(OAuthTokenRequest request) async {
    return _mockLoginResponse;
  }

  @override
  Future<OAuthLoginResponse> loginWithKakao(OAuthTokenRequest request) async {
    return _mockLoginResponse;
  }

  @override
  Future<OAuthLoginResponse> loginWithNaver(OAuthTokenRequest request) async {
    return _mockLoginResponse;
  }

  @override
  Future<ProfileSetupResponse> setupProfile(
    ProfileSetupRequest request,
    String signupToken,
  ) async {
    return const ProfileSetupResponse(
      accessToken: _mockAccessToken,
      refreshToken: _mockRefreshToken,
    );
  }

  @override
  Future<void> deleteAccount() async {}

  @override
  Future<MeResponse> getMe() async {
    return MeResponse(
      id: 'user_mock_001',
      username: '페달러123',
      avatarUrl: '',
      bio: '자전거와 함께하는 건강한 라이프스타일',
    );
  }
}

// MOCK END
