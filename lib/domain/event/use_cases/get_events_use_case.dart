import 'package:pedal/domain/event/entities/event_entity.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetEventsUseCase {
  final EventRepository _repository;
  GetEventsUseCase(this._repository);

  Future<({Failure? failure, List<EventEntity>? data})> call() {
    return _repository.getEvents();
  }
}
