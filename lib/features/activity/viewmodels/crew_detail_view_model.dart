import 'package:flutter/foundation.dart';
import 'package:pedal/domain/activity/entities/crew_detail_entity.dart';
import 'package:pedal/domain/activity/use_cases/get_crew_detail_use_case.dart';
import 'package:pedal/domain/activity/use_cases/join_crew_use_case.dart';

class CrewDetailViewModel extends ChangeNotifier {
  final GetCrewDetailUseCase _getCrewDetailUseCase;
  final JoinCrewUseCase _joinCrewUseCase;

  CrewDetailViewModel({
    required GetCrewDetailUseCase getCrewDetailUseCase,
    required JoinCrewUseCase joinCrewUseCase,
  }) : _getCrewDetailUseCase = getCrewDetailUseCase,
       _joinCrewUseCase = joinCrewUseCase;

  // 상태
  CrewDetailEntity? _crewDetail;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isJoined = false;
  int _selectedTabIndex = 0;

  // Getters
  CrewDetailEntity? get crewDetail => _crewDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isJoined => _isJoined;
  int get selectedTabIndex => _selectedTabIndex;
  int get memberCount => _crewDetail?.memberCount ?? 0;
  int get crewPoint => _crewDetail?.crewPoint ?? 0;

  Future<void> fetchCrewDetail(String crewId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getCrewDetailUseCase.execute(crewId);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (detail) => _crewDetail = detail,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> onJoinCrew(String crewId) async {
    if (_isJoined) return;

    final result = await _joinCrewUseCase.execute(crewId);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (_) => _isJoined = true,
    );

    notifyListeners();
  }

  void onTabChanged(int index) {
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    notifyListeners();
  }
}
