import 'package:flutter/material.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/domain/my/entities/challenge_entity.dart';
import 'package:pedal/features/my/widgets/challenge_list_item.dart';

class MyChallengesListPage extends StatelessWidget {
  final List<ChallengeEntity> challenges;
  final bool isLoading;
  final String? errorMessage;

  final void Function(String id) onChallengeTap;
  final VoidCallback onBackPressed;

  const MyChallengesListPage({
    super.key,
    required this.challenges,
    required this.isLoading,
    required this.errorMessage,
    required this.onChallengeTap,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BackAppBar(
        title: '참여한 챌린지',
        onBackPressed: onBackPressed,
        actions: [
          Text(
            '${challenges.length}',
            style: AppTextStyles.titSm.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!, style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary)),
      );
    }
    if (challenges.isEmpty) {
      return Center(
        child: Text('참여한 챌린지가 없습니다.', style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary)),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return ChallengeListItem(
          challenge: challenge,
          onTap: () => onChallengeTap(challenge.id),
        );
      },
    );
  }
}
