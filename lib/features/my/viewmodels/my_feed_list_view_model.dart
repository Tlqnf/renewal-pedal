import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/feed_entity.dart';
import 'package:pedal/domain/my/use_cases/get_my_feed_list_use_case.dart';

class MyFeedListViewModel extends ChangeNotifier {
  final GetMyFeedListUseCase _getMyFeedListUseCase;

  MyFeedListViewModel({
    required GetMyFeedListUseCase getMyFeedListUseCase,
  }) : _getMyFeedListUseCase = getMyFeedListUseCase;

  // 상태
  List<FeedEntity> _feeds = [];
  int _totalCount = 0;
  String _userName = '';
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  List<FeedEntity> get feeds => _feeds;
  int get totalCount => _totalCount;
  String get userName => _userName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFeedList({required String userId, required String userName}) async {
    _userName = userName;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getMyFeedListUseCase(userId: userId);

    if (result.failure != null) {
      _errorMessage = result.failure!.message;
    } else {
      _feeds = result.data ?? [];
      _totalCount = result.totalCount ?? 0;
    }

    _isLoading = false;
    notifyListeners();
  }

  void onFeedTap(String feedId) {
    // 라우팅은 Page(Connected)에서 처리
  }

  void onMoreTap() {
    // 라우팅은 Page(Connected)에서 처리
  }

  void onBack() {
    // 라우팅은 Page(Connected)에서 처리
  }
}
