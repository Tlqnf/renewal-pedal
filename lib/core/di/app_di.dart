import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pedal/core/config/app_config.dart';

// ── Infrastructure ───────────────────────────────────────────
import 'package:pedal/data/sources/secure_storage.dart';
import 'package:pedal/data/api/dio_client.dart';
import 'package:pedal/data/api/interceptors/auth_interceptor.dart';

// ── Mock Repositories ────────────────────────────────────────
import 'package:pedal/mock/sources/auth_mock_remote_source.dart';
import 'package:pedal/mock/sources/feed_mock_remote_source.dart';
import 'package:pedal/mock/sources/map_mock_remote_source.dart';
import 'package:pedal/mock/sources/ride_mock_remote_source.dart';
import 'package:pedal/mock/sources/notification_mock_remote_source.dart';
import 'package:pedal/mock/sources/activity_mock_repository.dart';
import 'package:pedal/mock/sources/activity_crew_detail_mock_repository.dart';
import 'package:pedal/mock/sources/statistics_mock_repository.dart';
import 'package:pedal/mock/sources/my_mock_repository.dart';
import 'package:pedal/mock/sources/my_routes_mock_repository.dart';
import 'package:pedal/mock/sources/my_feed_mock_repository.dart';
import 'package:pedal/mock/sources/my_feed_detail_mock_repository.dart';
import 'package:pedal/mock/sources/my_crew_mock_repository.dart';

// ── Real Remote Sources ──────────────────────────────────────
import 'package:pedal/data/auth/sources/auth_remote_source.dart';
import 'package:pedal/data/feed/sources/feed_remote_source.dart';
import 'package:pedal/data/map/sources/map_remote_source.dart';
import 'package:pedal/data/map/sources/ride_remote_source.dart';
import 'package:pedal/data/notification/sources/notification_remote_source.dart';
import 'package:pedal/data/activity/sources/crew_remote_source.dart';
import 'package:pedal/data/my/sources/my_remote_source.dart';
import 'package:pedal/data/calendar/sources/calendar_remote_source.dart';
import 'package:pedal/data/event/sources/event_remote_source.dart';
import 'package:pedal/data/gifticon/sources/gifticon_remote_source.dart';

// ── Real Repository Impls ────────────────────────────────────
import 'package:pedal/data/auth/repositories/auth_repository_impl.dart';
import 'package:pedal/data/feed/repositories/feed_repository_impl.dart';
import 'package:pedal/data/map/repositories/map_repository_impl.dart';
import 'package:pedal/data/map/repositories/ride_repository_impl.dart';
import 'package:pedal/data/notification/repositories/notification_repository_impl.dart';
import 'package:pedal/data/activity/repositories/activity_repository_impl.dart';
import 'package:pedal/data/activity/repositories/crew_detail_repository_impl.dart';
import 'package:pedal/data/my/repositories/my_repository_impl.dart';
import 'package:pedal/data/calendar/repositories/calendar_repository_impl.dart';
import 'package:pedal/data/event/repositories/event_repository_impl.dart';
import 'package:pedal/data/ranking/repositories/ranking_repository_impl.dart';
import 'package:pedal/data/ranking/sources/ranking_remote_source.dart';
import 'package:pedal/data/gifticon/repositories/gifticon_repository_impl.dart';

// ── Domain Interfaces ────────────────────────────────────────
import 'package:pedal/domain/auth/repositories/auth_repository.dart';
import 'package:pedal/domain/feed/repositories/feed_repository.dart';
import 'package:pedal/domain/map/repositories/map_repository.dart';
import 'package:pedal/domain/map/repositories/ride_repository.dart';
import 'package:pedal/domain/notifications/repositories/notification_repository.dart';
import 'package:pedal/domain/activity/repositories/activity_repository.dart';
import 'package:pedal/domain/activity/repositories/crew_detail_repository.dart';
import 'package:pedal/domain/statistics/repositories/statistics_repository.dart';
import 'package:pedal/domain/my/repositories/my_repository.dart';
import 'package:pedal/domain/my/repositories/my_feed_repository.dart';
import 'package:pedal/domain/my/repositories/my_feed_detail_repository.dart';
import 'package:pedal/domain/calendar/repositories/calendar_repository.dart';
import 'package:pedal/domain/event/repositories/event_repository.dart';
import 'package:pedal/domain/ranking/repositories/ranking_repository.dart';
import 'package:pedal/domain/gifticon/repositories/gifticon_repository.dart';

// ── Auth UseCases ────────────────────────────────────────────
import 'package:pedal/domain/auth/use_cases/delete_account_usecase.dart';
import 'package:pedal/domain/auth/use_cases/get_me_usecase.dart';
import 'package:pedal/domain/auth/use_cases/login_usecase.dart';
import 'package:pedal/domain/auth/use_cases/setup_profile_usecase.dart';
import 'package:pedal/domain/auth/use_cases/get_cached_access_token_usecase.dart';
import 'package:pedal/domain/auth/use_cases/get_cached_user_id_usecase.dart';
import 'package:pedal/domain/auth/use_cases/clear_tokens_usecase.dart';

// ── Sign-In Services ─────────────────────────────────────────
import 'package:pedal/services/google_sign_in/google_sign_in_service.dart';
import 'package:pedal/services/kakao_sign_in/kakao_sign_in_service.dart';
import 'package:pedal/services/naver_sign_in/naver_sign_in_service.dart';

// ── Feed UseCases ────────────────────────────────────────────
import 'package:pedal/domain/feed/use_cases/create_comment_usecase.dart';
import 'package:pedal/domain/feed/use_cases/create_feed_usecase.dart';
import 'package:pedal/domain/feed/use_cases/delete_comment_usecase.dart';
import 'package:pedal/domain/feed/use_cases/delete_feed_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_comments_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_feed_list_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_feed_status_usecase.dart';
import 'package:pedal/domain/feed/use_cases/get_replies_usecase.dart';
import 'package:pedal/domain/feed/use_cases/toggle_like_usecase.dart';
import 'package:pedal/domain/feed/use_cases/toggle_bookmark_usecase.dart';
import 'package:pedal/domain/feed/use_cases/toggle_comment_like_usecase.dart';
import 'package:pedal/domain/feed/use_cases/update_feed_usecase.dart';

// ── Map UseCases ─────────────────────────────────────────────
import 'package:pedal/domain/map/use_cases/ai_recommend_route_usecase.dart';
import 'package:pedal/domain/map/use_cases/finish_ride_usecase.dart';
import 'package:pedal/domain/map/use_cases/get_ride_track_usecase.dart';
import 'package:pedal/domain/map/use_cases/get_saved_routes_usecase.dart'
    as map_uc;

// ── Notification UseCases ────────────────────────────────────
import 'package:pedal/domain/notifications/use_cases/get_notifications_usecase.dart';
import 'package:pedal/domain/notifications/use_cases/read_notification_usecase.dart';
import 'package:pedal/domain/notifications/use_cases/delete_notification_usecase.dart';

// ── Activity UseCases ────────────────────────────────────────
import 'package:pedal/domain/activity/use_cases/get_recommended_crews_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_activity_stats_use_case.dart';
import 'package:pedal/domain/activity/use_cases/get_crew_detail_use_case.dart';
import 'package:pedal/domain/activity/use_cases/join_crew_use_case.dart';

// ── Statistics UseCases ──────────────────────────────────────
import 'package:pedal/domain/statistics/use_cases/get_weekly_stats_use_case.dart';

// ── My UseCases ──────────────────────────────────────────────
import 'package:pedal/domain/my/use_cases/get_my_profile_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_my_activity_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_saved_routes_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_my_feed_list_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_feed_detail_use_case.dart';
import 'package:pedal/domain/my/use_cases/toggle_feed_like_use_case.dart';
import 'package:pedal/domain/my/use_cases/toggle_feed_bookmark_use_case.dart';
import 'package:pedal/domain/my/use_cases/get_participated_crews_use_case.dart';

// ── Calendar UseCases ────────────────────────────────────────
import 'package:pedal/domain/calendar/use_cases/get_calendar_data_use_case.dart';

// ── Event UseCases ───────────────────────────────────────────
import 'package:pedal/domain/event/use_cases/get_events_use_case.dart';
import 'package:pedal/domain/event/use_cases/get_event_detail_use_case.dart';
import 'package:pedal/domain/event/use_cases/participate_event_use_case.dart';
import 'package:pedal/domain/event/use_cases/submit_event_request_use_case.dart';

// ── Ranking UseCases ─────────────────────────────────────────
import 'package:pedal/domain/ranking/use_cases/get_ranking_use_case.dart';

// ── Gifticon UseCases ─────────────────────────────────────────
import 'package:pedal/domain/gifticon/use_cases/get_gifticons_use_case.dart';
import 'package:pedal/domain/gifticon/use_cases/get_gifticon_detail_use_case.dart';
import 'package:pedal/domain/gifticon/use_cases/purchase_gifticon_use_case.dart';
import 'package:pedal/domain/gifticon/use_cases/get_my_gifticons_use_case.dart';
import 'package:pedal/domain/gifticon/use_cases/use_gifticon_use_case.dart';
import 'package:pedal/domain/gifticon/use_cases/get_point_transactions_use_case.dart';

// ── ViewModels ───────────────────────────────────────────────
import 'package:pedal/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:pedal/features/auth/viewmodels/initial_profile_viewmodel.dart';
import 'package:pedal/features/feed/viewmodels/feed_viewmodel.dart';
import 'package:pedal/features/map/viewmodels/map_viewmodel.dart';
import 'package:pedal/features/map/viewmodels/map_search_viewmodel.dart';
import 'package:pedal/features/notification/notification_viewmodel.dart';
import 'package:pedal/features/home/viewmodels/home_view_model.dart';
import 'package:pedal/features/crew/viewmodels/crew_view_model.dart';
import 'package:pedal/features/crew/viewmodels/crew_detail_view_model.dart';
import 'package:pedal/features/statistics/viewmodels/statistics_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_routes_list_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_feed_list_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_feed_detail_view_model.dart';
import 'package:pedal/features/my/viewmodels/my_crew_list_view_model.dart';
import 'package:pedal/features/my/viewmodels/edit_profile_viewmodel.dart';
import 'package:pedal/features/calendar/viewmodels/calendar_view_model.dart';
import 'package:pedal/features/event/viewmodels/event_view_model.dart';
import 'package:pedal/features/event/viewmodels/event_detail_view_model.dart';
import 'package:pedal/features/event/viewmodels/event_request_view_model.dart';
import 'package:pedal/features/ranking/viewmodels/ranking_view_model.dart';

class AppDI {
  final AuthViewModel authViewModel;
  final List<SingleChildWidget> providers;

  AppDI._({required this.authViewModel, required this.providers});

  static Future<AppDI> setup() async {
    final secureStorage = SecureStorage();
    final useMock = AppConfig.useMock;

    // DioClient 생성에 필요한 의존성
    // SecureStorage._storage는 private이므로 FlutterSecureStorage를 직접 생성
    final storage = const FlutterSecureStorage();
    final refreshDio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
    final authInterceptor = AuthInterceptor(storage, refreshDio);
    final dioClient = DioClient(authInterceptor);

    // ── Repositories ─────────────────────────────────────────
    // useMock=true  → Mock Repository (서버 없이 동작)
    // useMock=false → Real Repository (실제 서버 연동)

    final AuthRepository authRepository = useMock
        ? AuthRepositoryImpl(AuthMockRemoteSource(), secureStorage)
        : AuthRepositoryImpl(AuthRemoteSourceImpl(dioClient), secureStorage);

    final FeedRepository feedRepository = useMock
        ? FeedRepositoryImpl(FeedMockRemoteSource())
        : FeedRepositoryImpl(FeedRemoteSource(dioClient));

    final MapRepository mapRepository = useMock
        ? MapRepositoryImpl(MapMockRemoteSource())
        : MapRepositoryImpl(MapRemoteSource(dioClient));

    final RideRepository rideRepository = useMock
        ? RideRepositoryImpl(RideMockRemoteSource())
        : RideRepositoryImpl(RideRemoteSource(dioClient));

    final NotificationRepository notificationRepository = useMock
        ? NotificationRepositoryImpl(NotificationMockRemoteSource())
        : NotificationRepositoryImpl(NotificationRemoteSource(dioClient));

    final crewRemoteSource = CrewRemoteSource(dioClient);

    final ActivityRepository activityRepository = useMock
        ? ActivityMockRepository()
        : ActivityRepositoryImpl(crewRemoteSource);

    final CrewDetailRepository crewDetailRepository = useMock
        ? ActivityCrewDetailMockRepository()
        : CrewDetailRepositoryImpl(crewRemoteSource);

    final StatisticsRepository statisticsRepository = useMock
        ? StatisticsMockRepository()
        : StatisticsMockRepository(); // TODO: StatisticsRepositoryImpl(dioClient)

    final myRemoteSource = MyRemoteSource(dioClient);

    final MyRepository myRepository = useMock
        ? MyMockRepository()
        : MyRepositoryImpl(myRemoteSource);

    final MyRepository myCrewRepository = useMock
        ? MyCrewMockRepository()
        : MyRepositoryImpl(myRemoteSource); // 크루는 아직 API 없음, 빈 리스트 반환

    final MyRepository myRoutesRepository = useMock
        ? MyRoutesMockRepository()
        : MyRepositoryImpl(myRemoteSource);

    final MyFeedRepository myFeedRepository = useMock
        ? MyFeedMockRepository()
        : MyFeedMockRepository(); // TODO: MyFeedRepositoryImpl(dioClient)

    final MyFeedDetailRepository myFeedDetailRepository = useMock
        ? MyFeedDetailMockRepository()
        : MyFeedDetailMockRepository(); // TODO: MyFeedDetailRepositoryImpl(dioClient)

    final calendarRemoteSource = CalendarRemoteSource(dioClient);

    final CalendarRepository calendarRepository = useMock
        ? CalendarRepositoryImpl()
        : CalendarRepositoryImpl(calendarRemoteSource);

    final eventRemoteSource = EventRemoteSource(dioClient);

    final EventRepository eventRepository = useMock
        ? EventRepositoryImpl(eventRemoteSource)
        : EventRepositoryImpl(eventRemoteSource);

    final rankingRemoteSource = RankingRemoteSource(dioClient);
    final RankingRepository rankingRepository = useMock
        ? RankingRepositoryImpl()
        : RankingRepositoryImpl(rankingRemoteSource);

    final gifticonRemoteSource = GifticonRemoteSource(dioClient);
    final GifticonRepository gifticonRepository = useMock
        ? GifticonRepositoryImpl(gifticonRemoteSource)
        : GifticonRepositoryImpl(gifticonRemoteSource);

    // ── Sign-In Services ──────────────────────────────────────
    final googleSignInService = GoogleSignInService();
    final kakaoSignInService = KakaoSignInService();
    final naverSignInService = NaverSignInService();

    // ── Auth UseCases ─────────────────────────────────────────
    final googleLoginUseCase = GoogleLoginUseCase(authRepository);
    final kakaoLoginUseCase = KakaoLoginUseCase(authRepository);
    final naverLoginUseCase = NaverLoginUseCase(authRepository);
    final deleteAccountUseCase = DeleteAccountUseCase(authRepository);
    final getMeUseCase = GetMeUseCase(authRepository);
    final setupProfileUseCase = SetupProfileUseCase(authRepository);
    final getCachedAccessTokenUseCase = GetCachedAccessTokenUseCase(
      authRepository,
    );
    final getCachedUserIdUseCase = GetCachedUserIdUseCase(authRepository);
    final clearTokensUseCase = ClearTokensUseCase(authRepository);

    // ── Feed UseCases ─────────────────────────────────────────
    final getFeedListUseCase = GetFeedListUseCase(feedRepository);
    final createFeedUseCase = CreateFeedUseCase(feedRepository);
    final updateFeedUseCase = UpdateFeedUseCase(feedRepository);
    final deleteFeedUseCase = DeleteFeedUseCase(feedRepository);
    final likePostUseCase = LikePostUseCase(feedRepository);
    final unlikePostUseCase = UnlikePostUseCase(feedRepository);
    final bookmarkPostUseCase = BookmarkPostUseCase(feedRepository);
    final unbookmarkPostUseCase = UnbookmarkPostUseCase(feedRepository);
    final getCommentsUseCase = GetCommentsUseCase(feedRepository);
    final createCommentUseCase = CreateCommentUseCase(feedRepository);
    final deleteCommentUseCase = DeleteCommentUseCase(feedRepository);
    final toggleCommentLikeUseCase = ToggleCommentLikeUseCase(feedRepository);
    final getRepliesUseCase = GetRepliesUseCase(feedRepository);
    final getFeedStatusUseCase = GetFeedStatusUseCase(feedRepository);

    // ── Map UseCases ──────────────────────────────────────────
    final finishRideUseCase = FinishRideUseCase(rideRepository);
    final getSavedRoutesUseCase = map_uc.GetSavedRoutesUseCase(mapRepository);
    final aiRecommendRouteUseCase = AiRecommendRouteUseCase(mapRepository);
    final getRideTrackUseCase = GetRideTrackUseCase(rideRepository);

    // ── Notification UseCases ─────────────────────────────────
    final getNotificationsUseCase = GetNotificationsUseCase(
      notificationRepository,
    );
    final readNotificationUseCase = ReadNotificationUseCase(
      notificationRepository,
    );
    final deleteNotificationUseCase = DeleteNotificationUseCase(
      notificationRepository,
    );

    // ── Activity UseCases ─────────────────────────────────────
    final getRecommendedCrewsUseCase = GetRecommendedCrewsUseCase(
      activityRepository,
    );
    final getActivityStatsUseCase = GetActivityStatsUseCase(activityRepository);
    final getCrewDetailUseCase = GetCrewDetailUseCase(crewDetailRepository);
    final joinCrewUseCase = JoinCrewUseCase(crewDetailRepository);

    // ── Statistics UseCases ───────────────────────────────────
    final getWeeklyStatsUseCase = GetWeeklyStatsUseCase(statisticsRepository);

    // ── My UseCases ───────────────────────────────────────────
    final getMyProfileUseCase = GetMyProfileUseCase(myRepository);
    final getMyActivityUseCase = GetMyActivityUseCase(myRepository);
    final getMySavedRoutesUseCase = GetSavedRoutesUseCase(myRoutesRepository);
    final getParticipatedCrewsUseCase = GetParticipatedCrewsUseCase(
      myCrewRepository,
    );
    final getMyFeedListUseCase = GetMyFeedListUseCase(myFeedRepository);
    final getFeedDetailUseCase = GetFeedDetailUseCase(myFeedDetailRepository);
    final toggleFeedLikeUseCase = ToggleFeedLikeUseCase(myFeedDetailRepository);
    final toggleFeedBookmarkUseCase = ToggleFeedBookmarkUseCase(
      myFeedDetailRepository,
    );

    // ── Calendar UseCases ─────────────────────────────────────
    final getCalendarDataUseCase = GetCalendarDataUseCase(calendarRepository);

    // ── Event UseCases ────────────────────────────────────────
    final getEventsUseCase = GetEventsUseCase(eventRepository);
    final getEventDetailUseCase = GetEventDetailUseCase(eventRepository);
    final participateEventUseCase = ParticipateEventUseCase(eventRepository);
    final submitEventRequestUseCase = SubmitEventRequestUseCase(
      eventRepository,
    );

    // ── Ranking UseCases ──────────────────────────────────────
    final getRankingUseCase = GetRankingUseCase(rankingRepository);

    // ── Gifticon UseCases ─────────────────────────────────────
    final getGifticonsUseCase = GetGifticonsUseCase(gifticonRepository);
    final getGifticonDetailUseCase = GetGifticonDetailUseCase(
      gifticonRepository,
    );
    final purchaseGifticonUseCase = PurchaseGifticonUseCase(gifticonRepository);
    final getMyGifticonsUseCase = GetMyGifticonsUseCase(gifticonRepository);
    final useGifticonUseCase = UseGifticonUseCase(gifticonRepository);
    final getPointTransactionsUseCase = GetPointTransactionsUseCase(
      gifticonRepository,
    );

    // ── ViewModels ────────────────────────────────────────────
    final authViewModel = AuthViewModel(
      deleteAccountUseCase,
      getMeUseCase,
      getCachedAccessTokenUseCase,
      getCachedUserIdUseCase,
      clearTokensUseCase,
    );

    final feedViewModel = FeedViewModel(
      getFeedListUseCase,
      likePostUseCase,
      unlikePostUseCase,
      bookmarkPostUseCase,
      unbookmarkPostUseCase,
      getCommentsUseCase,
      createCommentUseCase,
      toggleCommentLikeUseCase,
      getRepliesUseCase,
      createFeedUseCase,
      updateFeedUseCase,
      deleteFeedUseCase,
      getFeedStatusUseCase,
      currentUserId: authViewModel.userId,
    );

    final mapViewModel = MapViewModel(
      finishRideUseCase,
      getSavedRoutesUseCase,
      aiRecommendRouteUseCase,
      getRideTrackUseCase,
      createFeedUseCase,
    );

    final mapSearchViewModel = MapSearchViewModel(getSavedRoutesUseCase);

    final notificationViewModel = NotificationViewModel(
      getNotificationsUseCase,
      readNotificationUseCase,
    );

    final homeViewModel = HomeViewModel();

    final activityViewModel = ActivityViewModel(
      getCrewsUseCase: getRecommendedCrewsUseCase,
      getStatsUseCase: getActivityStatsUseCase,
    );

    final crewDetailViewModel = CrewDetailViewModel(
      getCrewDetailUseCase: getCrewDetailUseCase,
      joinCrewUseCase: joinCrewUseCase,
    );

    final statisticsViewModel = StatisticsViewModel(
      getWeeklyStatsUseCase: getWeeklyStatsUseCase,
    );

    final myViewModel = MyViewModel(
      getMyProfileUseCase: getMyProfileUseCase,
      getMyActivityUseCase: getMyActivityUseCase,
    );

    final myRoutesListViewModel = MyRoutesListViewModel(
      getMySavedRoutesUseCase,
    );

    final myFeedListViewModel = MyFeedListViewModel(
      getMyFeedListUseCase: getMyFeedListUseCase,
    );

    final myFeedDetailViewModel = MyFeedDetailViewModel(
      getFeedDetailUseCase: getFeedDetailUseCase,
      toggleFeedLikeUseCase: toggleFeedLikeUseCase,
      toggleFeedBookmarkUseCase: toggleFeedBookmarkUseCase,
    );

    final myCrewListViewModel = MyCrewListViewModel(
      getParticipatedCrewsUseCase,
    );

    final editProfileViewModel = EditProfileViewModel(
      getMyProfileUseCase: getMyProfileUseCase,
    );

    final initialProfileViewModel = InitialProfileViewModel(
      setupProfileUseCase,
    );

    final calendarViewModel = CalendarViewModel(
      getCalendarDataUseCase: getCalendarDataUseCase,
    );

    final eventViewModel = EventViewModel(getEventsUseCase: getEventsUseCase);

    final eventDetailViewModel = EventDetailViewModel(
      getEventDetailUseCase: getEventDetailUseCase,
      participateEventUseCase: participateEventUseCase,
    );

    final eventRequestViewModel = EventRequestViewModel(
      submitEventRequestUseCase: submitEventRequestUseCase,
    );

    final rankingViewModel = RankingViewModel(
      getRankingUseCase: getRankingUseCase,
    );

    await authViewModel.tryAutoLogin();

    return AppDI._(
      authViewModel: authViewModel,
      providers: [
        ChangeNotifierProvider<AuthViewModel>.value(value: authViewModel),
        ChangeNotifierProvider<FeedViewModel>.value(value: feedViewModel),
        ChangeNotifierProvider<MapViewModel>.value(value: mapViewModel),
        ChangeNotifierProvider<MapSearchViewModel>.value(
          value: mapSearchViewModel,
        ),
        ChangeNotifierProvider<NotificationViewModel>.value(
          value: notificationViewModel,
        ),
        ChangeNotifierProvider<HomeViewModel>.value(value: homeViewModel),
        ChangeNotifierProvider<ActivityViewModel>.value(
          value: activityViewModel,
        ),
        ChangeNotifierProvider<CrewDetailViewModel>.value(
          value: crewDetailViewModel,
        ),
        ChangeNotifierProvider<StatisticsViewModel>.value(
          value: statisticsViewModel,
        ),
        ChangeNotifierProvider<MyViewModel>.value(value: myViewModel),
        ChangeNotifierProvider<MyRoutesListViewModel>.value(
          value: myRoutesListViewModel,
        ),
        ChangeNotifierProvider<MyFeedListViewModel>.value(
          value: myFeedListViewModel,
        ),
        ChangeNotifierProvider<MyFeedDetailViewModel>.value(
          value: myFeedDetailViewModel,
        ),
        ChangeNotifierProvider<MyCrewListViewModel>.value(
          value: myCrewListViewModel,
        ),
        ChangeNotifierProvider<EditProfileViewModel>.value(
          value: editProfileViewModel,
        ),
        ChangeNotifierProvider<InitialProfileViewModel>.value(
          value: initialProfileViewModel,
        ),
        ChangeNotifierProvider<CalendarViewModel>.value(
          value: calendarViewModel,
        ),
        ChangeNotifierProvider<EventViewModel>.value(value: eventViewModel),
        ChangeNotifierProvider<EventDetailViewModel>.value(
          value: eventDetailViewModel,
        ),
        ChangeNotifierProvider<EventRequestViewModel>.value(
          value: eventRequestViewModel,
        ),
        ChangeNotifierProvider<RankingViewModel>.value(value: rankingViewModel),
        Provider<GoogleLoginUseCase>.value(value: googleLoginUseCase),
        Provider<KakaoLoginUseCase>.value(value: kakaoLoginUseCase),
        Provider<NaverLoginUseCase>.value(value: naverLoginUseCase),
        Provider<GoogleSignInService>.value(value: googleSignInService),
        Provider<KakaoSignInService>.value(value: kakaoSignInService),
        Provider<NaverSignInService>.value(value: naverSignInService),
        Provider<DeleteCommentUseCase>.value(value: deleteCommentUseCase),
        Provider<CreateFeedUseCase>.value(value: createFeedUseCase),
        Provider<DeleteNotificationUseCase>.value(
          value: deleteNotificationUseCase,
        ),
        Provider<GetGifticonsUseCase>.value(value: getGifticonsUseCase),
        Provider<GetGifticonDetailUseCase>.value(
          value: getGifticonDetailUseCase,
        ),
        Provider<PurchaseGifticonUseCase>.value(value: purchaseGifticonUseCase),
        Provider<GetMyGifticonsUseCase>.value(value: getMyGifticonsUseCase),
        Provider<UseGifticonUseCase>.value(value: useGifticonUseCase),
        Provider<GetPointTransactionsUseCase>.value(
          value: getPointTransactionsUseCase,
        ),
      ],
    );
  }
}
