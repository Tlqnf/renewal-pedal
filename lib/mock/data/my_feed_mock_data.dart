import 'package:pedal/domain/my/entities/feed_entity.dart';

class MyFeedMockData {
  MyFeedMockData._();

  static final List<FeedEntity> feedList = [
    FeedEntity(
      id: 'feed_001',
      thumbnailUrl: 'https://picsum.photos/seed/feed1/400/400',
      hasMultipleImages: true,
      imageCount: 3,
      content: '한강 라이딩 후기',
      createdAt: DateTime(2026, 4, 20),
    ),
    FeedEntity(
      id: 'feed_002',
      thumbnailUrl: 'https://picsum.photos/seed/feed2/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '남산 코스',
      createdAt: DateTime(2026, 4, 18),
    ),
    FeedEntity(
      id: 'feed_003',
      thumbnailUrl: 'https://picsum.photos/seed/feed3/400/400',
      hasMultipleImages: true,
      imageCount: 5,
      content: '올림픽공원 라이딩',
      createdAt: DateTime(2026, 4, 15),
    ),
    FeedEntity(
      id: 'feed_004',
      thumbnailUrl: 'https://picsum.photos/seed/feed4/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '서울숲 산책',
      createdAt: DateTime(2026, 4, 10),
    ),
    FeedEntity(
      id: 'feed_005',
      thumbnailUrl: 'https://picsum.photos/seed/feed5/400/400',
      hasMultipleImages: true,
      imageCount: 2,
      content: '북한산 입구',
      createdAt: DateTime(2026, 4, 5),
    ),
    FeedEntity(
      id: 'feed_006',
      thumbnailUrl: 'https://picsum.photos/seed/feed6/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '양재천 코스',
      createdAt: DateTime(2026, 3, 30),
    ),
    FeedEntity(
      id: 'feed_007',
      thumbnailUrl: 'https://picsum.photos/seed/feed7/400/400',
      hasMultipleImages: true,
      imageCount: 4,
      content: '탄천 라이딩',
      createdAt: DateTime(2026, 3, 25),
    ),
    FeedEntity(
      id: 'feed_008',
      thumbnailUrl: 'https://picsum.photos/seed/feed8/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '인천 해변 코스',
      createdAt: DateTime(2026, 3, 20),
    ),
    FeedEntity(
      id: 'feed_009',
      thumbnailUrl: 'https://picsum.photos/seed/feed9/400/400',
      hasMultipleImages: true,
      imageCount: 6,
      content: '수원 둘레길',
      createdAt: DateTime(2026, 3, 15),
    ),
    FeedEntity(
      id: 'feed_010',
      thumbnailUrl: 'https://picsum.photos/seed/feed10/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '분당 야탑 코스',
      createdAt: DateTime(2026, 3, 10),
    ),
    FeedEntity(
      id: 'feed_011',
      thumbnailUrl: 'https://picsum.photos/seed/feed11/400/400',
      hasMultipleImages: true,
      imageCount: 3,
      content: '가평 자전거길',
      createdAt: DateTime(2026, 3, 5),
    ),
    FeedEntity(
      id: 'feed_012',
      thumbnailUrl: 'https://picsum.photos/seed/feed12/400/400',
      hasMultipleImages: false,
      imageCount: 1,
      content: '춘천 의암호',
      createdAt: DateTime(2026, 3, 1),
    ),
  ];

  static const List<FeedEntity> emptyList = [];

  static const int totalCount = 12;
}
