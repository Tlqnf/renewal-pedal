import 'package:flutter/foundation.dart';
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

  int _selectedTabIndex = 0;
  MyProfileEntity? _profile;
  List<CrewEntity> _crews = [];
  List<SavedRouteEntity> _savedRoutes = [];
  bool _isLoading = false;
  String? _errorMessage;

  int get selectedTabIndex => _selectedTabIndex;
  MyProfileEntity? get profile => _profile;
  List<CrewEntity> get crews => _crews;
  List<SavedRouteEntity> get savedRoutes => _savedRoutes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAll() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final profileResult = await _getMyProfileUseCase();
    if (profileResult.failure != null) {
      _errorMessage = profileResult.failure!.message;
      _isLoading = false;
      notifyListeners();
      return;
    }
    _profile = profileResult.data;

    final activityResult = await _getMyActivityUseCase();
    if (activityResult.failure != null) {
      _errorMessage = activityResult.failure!.message;
    } else {
      _crews = activityResult.crews ?? [];
      _savedRoutes = activityResult.routes ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void onTabChanged(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
