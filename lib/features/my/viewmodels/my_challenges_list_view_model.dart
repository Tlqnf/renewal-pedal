import 'package:flutter/foundation.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/domain/my/use_cases/get_participated_challenges_use_case.dart';

class MyChallengesListViewModel extends ChangeNotifier {
  final GetParticipatedChallengesUseCase _getParticipatedChallengesUseCase;

  MyChallengesListViewModel(this._getParticipatedChallengesUseCase);

  // 상태
  List<ChallengeEntity> _challenges = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter
  List<ChallengeEntity> get challenges => _challenges;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 초기 로드
  Future<void> fetchChallenges() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _getParticipatedChallengesUseCase.execute();

    result.fold(
      (failure) => _errorMessage = failure.message,
      (list) => _challenges = list,
    );

    _isLoading = false;
    notifyListeners();
  }

  // 액션
  void onChallengeTap(String id) {
    // 챌린지 상세 라우팅은 Router에서 처리
  }
}
