import 'package:flutter/foundation.dart';
import 'package:pedal/domain/auth/entities/auth_result_entity.dart';
import 'package:pedal/domain/auth/entities/user_entity.dart';
import 'package:pedal/domain/auth/repositories/auth_repository.dart';
import 'package:pedal/domain/auth/use_cases/delete_account_usecase.dart';
import 'package:pedal/domain/auth/use_cases/get_me_usecase.dart';
// import 'package:pedal/domain/use_cases/my/update_fcm_token_usecase.dart';
// import 'package:pedal/services/fcm/fcm_service.dart';

enum AuthState { initial, loading, loggedOut, needsProfileSetup, loggedIn }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GetMeUseCase _getMeUseCase;
  // final UpdateFcmTokenUseCase _updateFcmTokenUseCase;
  // final FcmService _fcmService;

  AuthViewModel(
    this._authRepository,
    this._deleteAccountUseCase,
    this._getMeUseCase,
    // this._updateFcmTokenUseCase,
    // this._fcmService,
  );

  AuthState _state = AuthState.initial;
  String? _accessToken;
  String? _userId;
  String? _errorMessage;
  String? _signupToken;
  UserEntity? _currentUser;

  AuthState get state => _state;
  String? get accessToken => _accessToken;
  String? get userId => _userId;
  String? get errorMessage => _errorMessage;
  String? get signupToken => _signupToken;
  UserEntity? get currentUser => _currentUser;
  bool get isAuthenticated => _state == AuthState.loggedIn;

  /// GET /auth/me — 현재 로그인 사용자 정보 조회
  Future<void> loadMe() async {
    final result = await _getMeUseCase.execute();
    result.fold((failure) => debugPrint('내 정보 조회 실패: ${failure.message}'), (
      user,
    ) {
      _currentUser = user;
      _userId = user.id;
      notifyListeners();
    });
  }

  /// FCM 토큰 발급 후 서버에 등록
  // Future<void> _registerFcmToken() async {
  //   final token = await _fcmService.getToken();
  //   if (token == null) return;
  //   final result = await _updateFcmTokenUseCase.execute(token);
  //   result.fold(
  //     (failure) => debugPrint('[Auth] FCM token registration failed: ${failure.message}'),
  //     (_) => debugPrint('[Auth] FCM token registered: $token'),
  //   );
  // }

  /// 앱 시작 시 저장된 토큰으로 자동 로그인 시도
  Future<void> tryAutoLogin() async {
    _state = AuthState.loading;
    notifyListeners();

    final token = await _authRepository.getCachedAccessToken();
    if (token != null) {
      _accessToken = token;
      _userId = await _authRepository.getCachedUserId();
      _state = AuthState.loggedIn;
      // await _registerFcmToken();
    } else {
      _state = AuthState.loggedOut;
    }
    notifyListeners();
  }

  /// 소셜 로그인 성공 후 OnboardingViewModel에서 호출
  void onLoginSuccess(AuthResultEntity result) {
    _accessToken = result.accessToken;
    _errorMessage = null;

    if (result.isNewUser) {
      _signupToken = result.signupToken;
      _state = AuthState.needsProfileSetup;
    } else {
      _signupToken = null;
      _state = AuthState.loggedIn;
      // _registerFcmToken();
    }
    notifyListeners();
  }

  /// 프로필 초기 설정 완료 후 호출
  void completeProfileSetup() {
    _state = AuthState.loggedIn;
    // _registerFcmToken();
    notifyListeners();
  }

  /// 프로필 설정 취소 — signupToken 폐기 후 loggedOut 전환
  Future<void> cancelProfileSetup() async {
    await _authRepository.clearTokens();
    _accessToken = null;
    _signupToken = null;
    _errorMessage = null;
    _state = AuthState.loggedOut;
    notifyListeners();
  }

  /// 로그아웃 — SecureStorage 전체 삭제(토큰 + user_id) 후 loggedOut 상태 전환
  Future<void> logout() async {
    await _authRepository.clearTokens();
    _accessToken = null;
    _userId = null;
    _signupToken = null;
    _errorMessage = null;
    _currentUser = null;
    _state = AuthState.loggedOut;
    notifyListeners();
  }

  /// 회원탈퇴 — DELETE /auth/account 호출 후 로컬 데이터(토큰 + user_id) 삭제
  /// 성공 시 true, 실패 시 errorMessage 설정 후 false 반환
  Future<bool> deleteAccount() async {
    _errorMessage = null;
    final result = await _deleteAccountUseCase.execute();
    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        _accessToken = null;
        _userId = null;
        _signupToken = null;
        _currentUser = null;
        _state = AuthState.loggedOut;
        notifyListeners();
        return true;
      },
    );
  }
}
