import 'package:flutter/foundation.dart';
import 'package:pedal/domain/event/entities/event_entity.dart';
import 'package:pedal/domain/event/use_cases/get_events_use_case.dart';

class EventViewModel extends ChangeNotifier {
  final GetEventsUseCase _getEventsUseCase;

  EventViewModel({required GetEventsUseCase getEventsUseCase})
      : _getEventsUseCase = getEventsUseCase;

  List<EventEntity> events = [];
  int currentImageIndex = 0;
  bool isLoading = false;
  String? errorMessage;

  EventEntity? get currentEvent => events.isNotEmpty ? events.first : null;

  Future<void> loadEvents() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getEventsUseCase();
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      events = result.data ?? [];
    }

    isLoading = false;
    notifyListeners();
  }

  void onPageChanged(int index) {
    currentImageIndex = index;
    notifyListeners();
  }
}
