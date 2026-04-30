import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/domain/feed/entities/feed_entity.dart';

const _coverImage = AppConstants.feedCover;

class FeedMockData {
  // 피드 목록
  static const List<FeedEntity> feeds = [
    FeedEntity(
      id: 'feed_001',
      userId: 'user_001',
      username: '김라이더',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '12.5km',
      title: '한강 자전거길 라이딩 완료!',
      description:
          '오늘 날씨가 너무 좋아서 한강 자전거길을 달려봤어요. 바람도 시원하고 경치도 좋아서 정말 즐거운 라이딩이었습니다. 다음에는 더 긴 코스에 도전해볼게요!',
      date: '2시간 전',
      likes: 24,
      comments: 5,
      isBookmarked: false,
    ),
    FeedEntity(
      id: 'feed_002',
      userId: 'user_002',
      username: '박사이클',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '8.2km',
      title: '아침 출근 라이딩',
      description: '오늘도 자전거 타고 출근했어요. 건강도 챙기고 환경도 지키고 일석이조!',
      date: '5시간 전',
      likes: 18,
      comments: 3,
      isBookmarked: false,
    ),
    FeedEntity(
      id: 'feed_003',
      userId: 'user_003',
      username: '최자전거',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '20.1km',
      title: '대청호 힐클라이밍 도전',
      description:
          '힘들었지만 정말 뿌듯한 라이딩이었습니다. 정상에서 본 풍경은 정말 환상적이었어요. 내려올 때 바람을 가르며 달리는 느낌이 최고였습니다. 다들 한번 도전해보세요!',
      date: '1일 전',
      likes: 42,
      comments: 8,
      isBookmarked: true,
    ),
    FeedEntity(
      id: 'feed_004',
      userId: 'user_004',
      username: '이바이크',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '5.5km',
      title: '퇴근길 가벼운 라이딩',
      description: '짧게 달렸지만 기분 좋은 라이딩이었어요.',
      date: '1일 전',
      likes: 12,
      comments: 2,
      isBookmarked: false,
    ),
    FeedEntity(
      id: 'feed_005',
      userId: 'user_005',
      username: '정페달',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '15.7km',
      title: '주말 여유로운 라이딩',
      description: '주말에는 역시 자전거 타야 제맛이죠! 날씨도 좋고 경치도 좋아서 정말 행복한 하루였습니다.',
      date: '2일 전',
      likes: 31,
      comments: 6,
      isBookmarked: false,
    ),
    FeedEntity(
      id: 'feed_006',
      userId: 'user_006',
      username: '강휠',
      userAvatarUrl: '',
      imageUrls: [_coverImage],
      routeDistance: '25.3km',
      title: '새벽 라이딩의 매력',
      description:
          '새벽 5시에 출발해서 시원한 바람을 맞으며 달렸습니다. 아침 해가 떠오르는 모습을 보며 라이딩하니 정말 감동적이었어요. 새벽 라이딩 강력 추천합니다!',
      date: '3일 전',
      likes: 56,
      comments: 12,
      isBookmarked: true,
    ),
  ];
}
