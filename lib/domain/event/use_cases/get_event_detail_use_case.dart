import 'package:pedal/domain/event/entities/event_detail_entity.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class GetEventDetailUseCase {
  final EventRepository _repository;
  GetEventDetailUseCase(this._repository);

  Future<({Failure? failure, EventDetailEntity? data})> call(String eventId) {
    return _repository.getEventDetail(eventId);
  }
}
