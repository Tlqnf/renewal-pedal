import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/crew_entity.dart';
import 'package:pedal/domain/my/use_cases/get_participated_crews_use_case.dart';

class MyCrewListViewModel extends ChangeNotifier {
  final GetParticipatedCrewsUseCase _getParticipatedCrewsUseCase;

  MyCrewListViewModel(this._getParticipatedCrewsUseCase);

  // 상태
  List<CrewEntity> _crewList = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  List<CrewEntity> get crewList => _crewList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 초기 로드
  Future<void> fetchCrewList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getParticipatedCrewsUseCase();

    if (result.failure != null) {
      _errorMessage = result.failure!.message;
    } else {
      _crewList = result.data ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // 액션: 라우팅은 Page/Router에서 처리
  void navigateToCrewDetail(String crewId) {}

  void navigateBack() {}
}
