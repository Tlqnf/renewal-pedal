import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:pedal/domain/auth/use_cases/login_usecase.dart';
import 'package:pedal/services/google_sign_in/google_sign_in_service.dart';
import 'package:pedal/services/kakao_sign_in/kakao_sign_in_service.dart';
import 'package:pedal/services/naver_sign_in/naver_sign_in_service.dart';

enum SocialLoginProvider { google, kakao, naver }

class OnboardingViewModel extends ChangeNotifier {
  final GoogleLoginUseCase _googleLoginUseCase;
  final KakaoLoginUseCase _kakaoLoginUseCase;
  // ignore: unused_field
  final NaverLoginUseCase _naverLoginUseCase;
  final GoogleSignInService _googleSignInService;
  final KakaoSignInService _kakaoSignInService;
  // ignore: unused_field
  final NaverSignInService _naverSignInService;

  OnboardingViewModel({
    required GoogleLoginUseCase googleLoginUseCase,
    required KakaoLoginUseCase kakaoLoginUseCase,
    required NaverLoginUseCase naverLoginUseCase,
    required GoogleSignInService googleSignInService,
    required KakaoSignInService kakaoSignInService,
    required NaverSignInService naverSignInService,
  }) : _googleLoginUseCase = googleLoginUseCase,
       _kakaoLoginUseCase = kakaoLoginUseCase,
       _naverLoginUseCase = naverLoginUseCase,
       _googleSignInService = googleSignInService,
       _kakaoSignInService = kakaoSignInService,
       _naverSignInService = naverSignInService;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> onSocialLogin(
    BuildContext context,
    SocialLoginProvider provider,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (provider == SocialLoginProvider.google) {
        final idToken = await _googleSignInService.getIdToken();
        if (idToken == null) {
          _errorMessage = '구글 로그인이 취소되었습니다';
          return;
        }
        final result = await _googleLoginUseCase.execute(idToken);
        if (!context.mounted) return;
        await result.fold(
          (failure) async => _errorMessage = failure.message,
          (authResult) =>
              context.read<AuthViewModel>().onLoginSuccess(authResult),
        );
      } else if (provider == SocialLoginProvider.kakao) {
        final accessToken = await _kakaoSignInService.getAccessToken();
        if (accessToken == null) {
          _errorMessage = '카카오 로그인이 취소되었습니다';
          return;
        }
        final result = await _kakaoLoginUseCase.execute(accessToken);
        if (!context.mounted) return;
        await result.fold(
          (failure) async => _errorMessage = failure.message,
          (authResult) =>
              context.read<AuthViewModel>().onLoginSuccess(authResult),
        );
      } else if (provider == SocialLoginProvider.naver) {
        // 네이버 로그인은 미연동 상태 — SDK 설정 완료 후 활성화 예정
        _errorMessage = '네이버 로그인은 준비 중입니다';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
