import 'package:dio/dio.dart';
import 'package:pedal/data/api/api_endpoints.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/models/auth/login_request.dart';
import 'package:pedal/data/models/auth/login_response.dart';
import 'package:pedal/data/models/auth/me_response.dart';
import 'package:pedal/data/models/auth/profile_setup_request.dart';
import 'package:pedal/data/models/auth/profile_setup_response.dart';

abstract class AuthRemoteSource {
  Future<OAuthLoginResponse> loginWithGoogle(OAuthTokenRequest request);
  Future<OAuthLoginResponse> loginWithKakao(OAuthTokenRequest request);
  Future<OAuthLoginResponse> loginWithNaver(OAuthTokenRequest request);
  Future<ProfileSetupResponse> setupProfile(
    ProfileSetupRequest request,
    String signupToken,
  );
  Future<void> deleteAccount();
  Future<MeResponse> getMe();
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final DioClient _client;

  AuthRemoteSourceImpl(this._client);

  @override
  Future<OAuthLoginResponse> loginWithGoogle(OAuthTokenRequest request) async {
    final response = await _client.post(
      ApiEndpoints.googleLogin,
      data: request.toJson(),
    );
    return OAuthLoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OAuthLoginResponse> loginWithKakao(OAuthTokenRequest request) async {
    final response = await _client.post(
      ApiEndpoints.kakaoLogin,
      data: request.toJson(),
    );
    return OAuthLoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OAuthLoginResponse> loginWithNaver(OAuthTokenRequest request) async {
    final response = await _client.post(
      ApiEndpoints.naverLogin,
      data: request.toJson(),
    );
    return OAuthLoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProfileSetupResponse> setupProfile(
    ProfileSetupRequest request,
    String signupToken,
  ) async {
    final formData = await request.toFormData();
    final response = await _client.post(
      ApiEndpoints.profileSetup,
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $signupToken'}),
    );
    return ProfileSetupResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteAccount() async {
    await _client.delete(ApiEndpoints.deleteAccount);
  }

  @override
  Future<MeResponse> getMe() async {
    final response = await _client.get('/auth/me');
    return MeResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
