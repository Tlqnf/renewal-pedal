import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class ParticipateEventUseCase {
  final EventRepository _repository;
  ParticipateEventUseCase(this._repository);

  Future<({Failure? failure})> call(String eventId) {
    return _repository.participateEvent(eventId);
  }
}
