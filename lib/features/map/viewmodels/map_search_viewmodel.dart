import 'package:flutter/material.dart';
import 'package:pedal/domain/map/entities/route_entity.dart';
import 'package:pedal/domain/map/use_cases/get_saved_routes_usecase.dart';

class MapSearchViewModel extends ChangeNotifier {
  final GetSavedRoutesUseCase _getSavedRoutesUseCase;

  MapSearchViewModel(this._getSavedRoutesUseCase);

  // 전체 루트 목록
  List<RouteEntity> _routes = [];

  // 로딩 상태
  bool _isLoading = false;

  // 에러 메시지
  String? _errorMessage;

  // Getters
  List<RouteEntity> get routes => _routes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 루트 데이터 로드 (GET /map/saved)
  Future<void> searchRoutes({String? search}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getSavedRoutesUseCase.execute(search: search);

    result.fold(
      (failure) => _errorMessage = failure.message,
      (routes) => _routes = routes,
    );

    _isLoading = false;
    notifyListeners();
  }

  void onSearchSubmitted(String query) {
    searchRoutes(search: query);
  }
}
