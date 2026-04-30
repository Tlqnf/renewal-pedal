// MOCK START - UI 테스트용. 실제 서버 연동 시 이 파일 및 DI의 MOCK 블록 제거
import 'package:pedal/data/models/crew/crew_create_request.dart';
import 'package:pedal/data/models/crew/crew_detail_response.dart';
import 'package:pedal/data/models/crew/crew_member_response.dart';
import 'package:pedal/data/models/crew/crew_post_create_request.dart';
import 'package:pedal/data/models/crew/crew_response.dart';
import 'package:pedal/data/models/crew/crew_update_request.dart';
import 'package:pedal/data/models/feed/feed_response.dart';
import 'package:pedal/mock/data/crew_mock_data.dart';
import 'package:pedal/mock/data/feed_mock_data.dart';

class CrewMockRemoteSource {
  CrewResponse _entityToResponse(dynamic e) => CrewResponse(
    id: e.id,
    imageUrl: e.imageUrl ?? '',
    name: e.name,
    location: e.location,
    memberCount: e.memberCount,
  );

  Future<List<CrewResponse>> getMyCrews() async {
    // MOCK: CrewMockData.joinedCrews → CrewResponse 변환
    return CrewMockData.joinedCrews.map(_entityToResponse).toList();
  }

  Future<List<CrewResponse>> getCrews({int limit = 10, int offset = 0}) async {
    // MOCK: 전체 크루 목록 (가입 + 추천)
    final all = [...CrewMockData.joinedCrews, ...CrewMockData.recommendedCrews];
    return all.map(_entityToResponse).toList();
  }

  Future<List<CrewResponse>> getRecommendCrews() async {
    // MOCK: CrewMockData.recommendedCrews → CrewResponse 변환
    return CrewMockData.recommendedCrews.map(_entityToResponse).toList();
  }

  Future<void> joinCrew(String crewId) async {}

  Future<String> createCrew(CrewCreateRequest request) async {
    return 'crew_new_001';
  }

  Future<CrewDetailResponse> getCrewById(String crewId) async {
    // MOCK: id로 찾거나 첫 번째 크루 반환
    final all = [...CrewMockData.joinedCrews, ...CrewMockData.recommendedCrews];
    final found = all.firstWhere(
      (e) => e.id == crewId,
      orElse: () => CrewMockData.joinedCrews.first,
    );
    return CrewDetailResponse(
      id: found.id,
      imageUrl: found.imageUrl ?? '',
      name: found.name,
      location: found.location,
      memberCount: found.memberCount,
      description: '자전거를 사랑하는 사람들의 모임입니다.',
      crewTypes: ['road', 'mtb'],
      isPublic: true,
      isJoined: true,
      isOwner: false,
      isAdmin: false,
    );
  }

  Future<void> updateCrew(String crewId, CrewUpdateRequest request) async {}

  Future<void> deleteCrew(String crewId) async {}

  Future<void> leaveCrew(String crewId) async {}

  Future<List<CrewMemberResponse>> getCrewMembers(
    String crewId, {
    int limit = 100,
    int offset = 0,
  }) async {
    // MOCK: 샘플 크루 멤버 데이터
    return const [
      CrewMemberResponse(id: 'user_001', username: '김라이더', avatarUrl: ''),
      CrewMemberResponse(id: 'user_002', username: '박사이클', avatarUrl: ''),
      CrewMemberResponse(id: 'user_003', username: '최자전거', avatarUrl: ''),
      CrewMemberResponse(id: 'user_004', username: '이바이크', avatarUrl: ''),
    ];
  }

  Future<List<FeedResponse>> getCrewFeeds(
    String crewId, {
    int limit = 20,
    int offset = 0,
  }) async {
    // MOCK: FeedMockData.feeds → FeedResponse 변환
    return FeedMockData.feeds
        .map(
          (e) => FeedResponse(
            id: e.id,
            userId: e.userId,
            username: e.username,
            userAvatarUrl: e.userAvatarUrl,
            imageUrls: e.imageUrls,
            routeDistance: e.routeDistance,
            title: e.title,
            description: e.description,
            date: e.date,
            likes: e.likes,
            comments: e.comments,
            isBookmarked: e.isBookmarked,
          ),
        )
        .toList();
  }

  Future<void> createCrewPost(
    String crewId,
    CrewPostCreateRequest request,
  ) async {}
}

// MOCK END
