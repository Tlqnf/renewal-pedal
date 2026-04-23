import 'package:pedal/domain/my/entities/feed_detail_entity.dart';

class MyFeedDetailMockData {
  MyFeedDetailMockData._();

  static final FeedDetailEntity feedDetail = FeedDetailEntity(
    id: 'feed_001',
    authorUserId: 'user_001',
    authorNickname: '뺑빵아',
    authorProfileImageUrl: 'https://picsum.photos/seed/profile1/100/100',
    feedImageUrl: 'https://picsum.photos/seed/feed_detail1/800/600',
    likeCount: 1000,
    commentCount: 50,
    isLiked: false,
    isBookmarked: false,
    hashtags: ['뺑빵이', '안녕'],
    title: '라이딩 중 신기한 장소 발견',
    content:
        '내가 보기에는 정말 신기한 장소가 맞는 거 같음! 아니 세상에 이런 곳이 있다니 믿기지가 않아요. 한강 자전거길을 달리다가 우연히 발견한 비밀 정원 같은 곳이에요. 꼭 한번 가보세요!',
    createdAt: DateTime(2026, 1, 28),
  );

  static final List<FeedDetailEntity> feedDetailList = [
    feedDetail,
    FeedDetailEntity(
      id: 'feed_002',
      authorUserId: 'user_001',
      authorNickname: '뺑빵아',
      authorProfileImageUrl: 'https://picsum.photos/seed/profile1/100/100',
      feedImageUrl: 'https://picsum.photos/seed/feed_detail2/800/600',
      likeCount: 234,
      commentCount: 12,
      isLiked: true,
      isBookmarked: false,
      hashtags: ['남산', '야경', '자전거'],
      title: '남산 야간 라이딩 후기',
      content:
          '밤에 남산을 자전거로 올라가봤어요. 야경이 정말 장관이었어요. 체력이 많이 필요하지만 충분히 가볼 만한 코스입니다. 특히 해가 지는 시간에 맞춰 출발하면 더욱 아름다운 풍경을 볼 수 있어요.',
      createdAt: DateTime(2026, 2, 10),
    ),
    FeedDetailEntity(
      id: 'feed_003',
      authorUserId: 'user_001',
      authorNickname: '뺑빵아',
      authorProfileImageUrl: 'https://picsum.photos/seed/profile1/100/100',
      feedImageUrl: 'https://picsum.photos/seed/feed_detail3/800/600',
      likeCount: 89,
      commentCount: 7,
      isLiked: false,
      isBookmarked: true,
      hashtags: ['올림픽공원', '봄'],
      title: '올림픽공원 봄꽃 라이딩',
      content:
          '올림픽공원에 벚꽃이 만발했어요! 자전거 타면서 구경하는 맛이 정말 최고입니다. 주말에는 사람이 많으니 평일 이른 아침에 방문하는 걸 추천해요.',
      createdAt: DateTime(2026, 3, 22),
    ),
  ];
}
