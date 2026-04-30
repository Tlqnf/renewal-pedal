import 'package:flutter/material.dart';
import 'package:pedal/domain/my/use_cases/get_my_profile_use_case.dart';

class EditProfileViewModel extends ChangeNotifier {
  final GetMyProfileUseCase _getMyProfileUseCase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? _profileImageUrl;
  bool _isLoading = false;
  String? _errorMessage;

  String? get profileImageUrl => _profileImageUrl;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  EditProfileViewModel({required GetMyProfileUseCase getMyProfileUseCase})
    : _getMyProfileUseCase = getMyProfileUseCase {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getMyProfileUseCase();
    if (result.failure != null) {
      _errorMessage = result.failure!.message;
    } else if (result.data != null) {
      final profile = result.data!;
      nameController.text = profile.nickname;
      _profileImageUrl = profile.profileImageUrl;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setProfileImageUrl(String? url) {
    _profileImageUrl = url;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
