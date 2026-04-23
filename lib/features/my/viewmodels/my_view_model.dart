import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/use_cases/get_my_activity_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_my_profile_use_case.dart';

class MyViewModel extends ChangeNotifier {
  final GetMyProfileUseCase _getMyProfileUseCase;
  final GetMyActivityUseCase _getMyActivityUseCase;

  MyViewModel({
    required GetMyProfileUseCase getMyProfileUseCase,
    required GetMyActivityUseCase getMyActivityUseCase,
  }) : _getMyProfileUseCase = getMyProfileUseCase,
       _getMyActivityUseCase = getMyActivityUseCase;

  int selectedTabIndex = 0;
  MyProfileEntity? profile;
  List<ChallengeEntity> challenges = [];
  List<CrewEntity> crews = [];
  List<SavedRouteEntity> savedRoutes = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadAll() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final profileResult = await _getMyProfileUseCase();
    if (profileResult.failure != null) {
      errorMessage = profileResult.failure!.message;
      isLoading = false;
      notifyListeners();
      return;
    }
    profile = profileResult.data;

    final activityResult = await _getMyActivityUseCase();
    if (activityResult.failure != null) {
      errorMessage = activityResult.failure!.message;
    } else {
      challenges = activityResult.challenges ?? [];
      crews = activityResult.crews ?? [];
      savedRoutes = activityResult.routes ?? [];
    }

    isLoading = false;
    notifyListeners();
  }

  void onTabChanged(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }
}
