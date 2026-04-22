import 'package:pedal/domain/event/entities/event_request_entity.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class SubmitEventRequestUseCase {
  final EventRepository _repository;
  SubmitEventRequestUseCase(this._repository);

  Future<({Failure? failure})> call(EventRequestEntity request) {
    return _repository.submitEventRequest(request);
  }
}
