import 'package:flutter/foundation.dart';
import 'package:pedal/domain/event/entities/event_request_entity.dart';
import 'package:pedal/domain/event/use_cases/submit_event_request_use_case.dart';

class EventRequestViewModel extends ChangeNotifier {
  final SubmitEventRequestUseCase _submitEventRequestUseCase;

  EventRequestViewModel({required SubmitEventRequestUseCase submitEventRequestUseCase})
      : _submitEventRequestUseCase = submitEventRequestUseCase;

  String? selectedEventId;
  String? selectedEventTitle;
  String? selectedEventThumbnailUrl;
  String? uploadedImagePath;
  String memo = '';
  bool isLoading = false;
  String? errorMessage;
  bool isSubmitted = false;

  void setSelectedEvent({
    required String id,
    required String title,
    String? thumbnailUrl,
  }) {
    selectedEventId = id;
    selectedEventTitle = title;
    selectedEventThumbnailUrl = thumbnailUrl;
    notifyListeners();
  }

  void onImagePicked(String path) {
    uploadedImagePath = path;
    notifyListeners();
  }

  void onMemoChanged(String value) {
    memo = value;
    notifyListeners();
  }

  Future<void> onSubmit() async {
    if (selectedEventId == null || uploadedImagePath == null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _submitEventRequestUseCase(
      EventRequestEntity(
        eventId: selectedEventId!,
        imagePath: uploadedImagePath!,
        memo: memo.isEmpty ? null : memo,
      ),
    );

    if (result.failure != null) {
      errorMessage = result.failure!.message;
    } else {
      isSubmitted = true;
    }

    isLoading = false;
    notifyListeners();
  }
}
