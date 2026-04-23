import 'package:flutter/foundation.dart';
import 'package:pedal/domain/activity/entities/challenge_detail_entity.dart';
import 'package:pedal/domain/activity/entities/challenge_ranking_entity.dart';
import 'package:pedal/domain/activity/use_cases/get_challenge_detail_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_challenge_ranking_use_case.dart';
import 'package:pedal/domain/activity/use_cases/participate_challenge_use_case.dart';

class ActivityChallengeDetailViewModel extends ChangeNotifier {
  final GetChallengeDetailUseCase _getChallengeDetailUseCase;
  final GetChallengeRankingUseCase _getChallengeRankingUseCase;
  final ParticipateChallengeUseCase _participateChallengeUseCase;

  ActivityChallengeDetailViewModel({
    required GetChallengeDetailUseCase getChallengeDetailUseCase,
    required GetChallengeRankingUseCase getChallengeRankingUseCase,
    required ParticipateChallengeUseCase participateChallengeUseCase,
  }) : _getChallengeDetailUseCase = getChallengeDetailUseCase,
       _getChallengeRankingUseCase = getChallengeRankingUseCase,
       _participateChallengeUseCase = participateChallengeUseCase;

  // State
  ChallengeDetailEntity? _challengeDetail;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDescriptionExpanded = false;
  int _selectedTabIndex = 0;
  bool _isParticipating = false;
  List<ChallengeRankingEntity> _rankingList = [];

  // Getters
  ChallengeDetailEntity? get challengeDetail => _challengeDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isDescriptionExpanded => _isDescriptionExpanded;
  int get selectedTabIndex => _selectedTabIndex;
  bool get isParticipating => _isParticipating;
  List<ChallengeRankingEntity> get rankingList => _rankingList;

  Future<void> loadChallengeDetail(String challengeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final detailResult = await _getChallengeDetailUseCase(challengeId);
    if (detailResult.failure != null) {
      _errorMessage = detailResult.failure!.message;
    } else {
      _challengeDetail = detailResult.data;
      _isParticipating = detailResult.data?.isParticipating ?? false;
    }

    final rankingResult = await _getChallengeRankingUseCase(challengeId);
    if (rankingResult.failure == null) {
      _rankingList = rankingResult.data ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void onToggleDescription() {
    _isDescriptionExpanded = !_isDescriptionExpanded;
    notifyListeners();
  }

  void onTabChanged(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> onParticipatePressed(String challengeId) async {
    if (_isParticipating) return;

    _isParticipating = true;
    notifyListeners();

    final result = await _participateChallengeUseCase(challengeId);
    if (result.failure != null) {
      _isParticipating = false;
      _errorMessage = result.failure!.message;
    }

    notifyListeners();
  }

  void onBackPressed() {
    // 라우팅은 Page에서 처리
  }

  void onSharePressed() {
    // 공유 기능은 Page에서 처리
  }
}
