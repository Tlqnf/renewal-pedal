import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/saved_route_entity.dart';
import 'package:pedal/domain/my/use_cases/get_saved_routes_use_case.dart';

class MyRoutesListViewModel extends ChangeNotifier {
  final GetSavedRoutesUseCase _getSavedRoutesUseCase;

  MyRoutesListViewModel(this._getSavedRoutesUseCase);

  // 상태
  List<SavedRouteEntity> _routeList = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  List<SavedRouteEntity> get routeList => _routeList;
  int get routeCount => _routeList.length;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 초기 로드
  Future<void> fetchRoutes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getSavedRoutesUseCase.execute();

    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _routeList = list,
    );

    _isLoading = false;
    notifyListeners();
  }

  // 액션
  void onBack() {
    // 라우팅은 Page에서 처리
  }

  void onRouteTap(String id) {
    // 라우팅은 Page에서 처리
  }
}
