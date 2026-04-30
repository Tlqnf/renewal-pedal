import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/domain/auth/use_cases/setup_profile_usecase.dart';
import 'package:pedal/features/auth/viewmodels/auth_viewmodel.dart';

class InitialProfileViewModel extends ChangeNotifier {
  final SetupProfileUseCase _setupProfileUseCase;

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _profileImagePath;
  bool _isLoading = false;
  String? _errorMessage;

  InitialProfileViewModel(this._setupProfileUseCase) {
    nicknameController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  String? get profileImagePath => _profileImagePath;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get canSubmit {
    return !_isLoading &&
        _profileImagePath != null &&
        nicknameController.text.trim().isNotEmpty;
  }

  void setProfileImage(String? imagePath) {
    _profileImagePath = imagePath;
    notifyListeners();
  }

  Future<void> submitProfile(BuildContext context) async {
    if (!canSubmit) return;

    final authViewModel = context.read<AuthViewModel>();
    final signupToken = authViewModel.signupToken;

    if (signupToken == null) {
      _errorMessage = '로그인 정보가 없습니다. 다시 로그인해주세요.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _setupProfileUseCase.execute(
      signupToken: signupToken,
      nickname: nicknameController.text.trim(),
      bio: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      profileImage: File(_profileImagePath!),
    );

    _isLoading = false;

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (_) async {
        if (context.mounted) {
          await authViewModel.completeProfileSetup();
        }
      },
    );
  }

  @override
  void dispose() {
    nicknameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
