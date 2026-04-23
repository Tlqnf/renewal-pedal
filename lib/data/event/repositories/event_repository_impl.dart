import 'package:pedal/domain/event/entities/event_detail_entity.dart';
import 'package:pedal/domain/event/entities/event_entity.dart';
import 'package:pedal/domain/event/entities/event_request_entity.dart';
import 'package:pedal/domain/event/entities/event_step_entity.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/failures/failures.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<({Failure? failure, List<EventEntity>? data})> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: [
        const EventEntity(
          id: 'event_1',
          title: '라이딩하고 치킨까지 득템',
          subtitle: '이번 달 목표 거리를 달성하면 치킨 기프티콘을 드려요. 지금 바로 도전해보세요!',
          imageUrls: ['', '', '', '', ''],
        ),
      ],
    );
  }

  @override
  Future<({Failure? failure, EventDetailEntity? data})> getEventDetail(
    String eventId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (
      failure: null,
      data: EventDetailEntity(
        id: eventId,
        title: '라이딩하고 치킨까지 득템',
        bannerImageUrl: '',
        participationRestriction: '참여 제약 없음',
        startDate: DateTime(2026, 4, 1),
        endDate: DateTime(2026, 4, 30),
        description:
            '이번 달 목표 거리를 달성하면 치킨 기프티콘을 드려요.\n매일 꾸준히 라이딩하며 건강도 챙기고 상품도 받아가세요!',
        steps: const [
          EventStepEntity(
            stepNumber: 1,
            title: '앱에서 라이딩 시작',
            description: '페달 앱을 실행하고 지도 탭에서 라이딩을 시작하세요.',
          ),
          EventStepEntity(
            stepNumber: 2,
            title: '월 목표 거리 달성',
            description: '4월 한 달 동안 총 100km 이상을 라이딩하세요.',
          ),
          EventStepEntity(
            stepNumber: 3,
            title: '이벤트 인증 제출',
            description: '라이딩 완료 후 이벤트 인증 화면에서 스크린샷을 제출하세요.',
          ),
        ],
      ),
    );
  }

  @override
  Future<({Failure? failure})> participateEvent(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return (failure: null);
  }

  @override
  Future<({Failure? failure})> submitEventRequest(
    EventRequestEntity request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return (failure: null);
  }
}
