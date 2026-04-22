import 'package:flutter/foundation.dart';
import 'package:pedal/domain/event/entities/event_detail_entity.dart';
import 'package:pedal/domain/event/use_cases/get_event_detail_use_case.dart';
import 'package:pedal/domain/event/use_cases/participate_event_use_case.dart';

class EventDetailViewModel extends ChangeNotifier {
  final GetEventDetailUseCase _getEventDetailUseCase;
  final ParticipateEventUseCase _participateEventUseCase;

  EventDetailViewModel({
    required GetEventDetailUseCase getEventDetailUseCase,
    required ParticipateEventUseCase participateEventUseCase,
  })  : _getEventDetailUseCase = getEventDetailUseCase,
        _participateEventUseCase = participateEventUseCase;

  EventDetailEntity? event;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadEvent(String eventId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _getEventDetailUseCase(eventId);
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      event = result.data;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> onParticipate(String eventId) async {
    isLoading = true;
    notifyListeners();

    final result = await _participateEventUseCase(eventId);
    if (result.failure != null) {
      errorMessage = result.failure!.message;
    }

    isLoading = false;
    notifyListeners();
  }
}
