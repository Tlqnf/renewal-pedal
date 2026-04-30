import 'package:pedal/domain/ranking/entities/ranking_entity.dart';

class RankingUserItemResponse {
  final int rank;
  final String userId;
  final String nickname;
  final String? profileImageUrl;
  final int value;
  final String displayValue;

  const RankingUserItemResponse({
    required this.rank,
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.value,
    required this.displayValue,
  });

  factory RankingUserItemResponse.fromJson(Map<String, dynamic> json) =>
      RankingUserItemResponse(
        rank: json['rank'] as int,
        userId: json['user_id'] as String,
        nickname: json['nickname'] as String,
        profileImageUrl: json['profile_image_url'] as String?,
        value: json['value'] as int,
        displayValue: json['display_value'] as String,
      );

  RankingEntity toEntity() => RankingEntity(
    userId: userId,
    nickname: nickname,
    profileImageUrl: profileImageUrl,
    rank: rank,
    value: value.toDouble(),
    unit: displayValue,
  );
}

class RankingResponse {
  final String rankingType;
  final List<RankingUserItemResponse> top10;
  final RankingUserItemResponse? myRank;

  const RankingResponse({
    required this.rankingType,
    required this.top10,
    this.myRank,
  });

  factory RankingResponse.fromJson(Map<String, dynamic> json) =>
      RankingResponse(
        rankingType: json['ranking_type'] as String,
        top10: (json['top10'] as List)
            .map(
              (e) =>
                  RankingUserItemResponse.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        myRank: json['my_rank'] == null
            ? null
            : RankingUserItemResponse.fromJson(
                json['my_rank'] as Map<String, dynamic>,
              ),
      );
}
