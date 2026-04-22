import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/domain/my/entities/my_profile_entity.dart';

class ProfileHeaderSection extends StatelessWidget {
  final MyProfileEntity profile;
  final VoidCallback onSettingsTap;
  final VoidCallback onReportTap;
  final VoidCallback onFollowerTap;
  final VoidCallback onFollowingTap;

  const ProfileHeaderSection({
    super.key,
    required this.profile,
    required this.onSettingsTap,
    required this.onReportTap,
    required this.onFollowerTap,
    required this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(
                  child: Icon(Icons.person_rounded, color: AppColors.gray400, size: 36),
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(profile.nickname, style: AppTextStyles.titLg),
              ),
              IconButton(
                onPressed: onSettingsTap,
                icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _CountItem(
                label: '팔로워',
                count: profile.followerCount,
                onTap: onFollowerTap,
              ),
              SizedBox(width: AppSpacing.lg),
              _CountItem(
                label: '팔로잉',
                count: profile.followingCount,
                onTap: onFollowingTap,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onReportTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: AppRadius.fullAll,
                  ),
                  child: Text(
                    '신고하기',
                    style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountItem extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onTap;

  const _CountItem({required this.label, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$count', style: AppTextStyles.titMd),
          Text(
            label,
            style: AppTextStyles.txtXs.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
