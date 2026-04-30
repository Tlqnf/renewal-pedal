import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedal/common/components/appbars/back_appbar.dart';
import 'package:pedal/common/components/buttons/primary_button.dart';
import 'package:pedal/common/components/inputs/app_text_field.dart';
import 'package:pedal/common/components/inputs/image_upload_box.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/features/auth/viewmodels/initial_profile_viewmodel.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<InitialProfileViewModel>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: BackAppBar(title: ''),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    Text(
                      '프로필 설정',
                      style: AppTextStyles.txtSm.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // 프로필 사진
                    RichText(
                      text: TextSpan(
                        text: '프로필 사진',
                        style: AppTextStyles.titXs,
                        children: const [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ImageUploadBox(
                      imageUrl: vm.profileImagePath,
                      onImageSelected: vm.setProfileImage,
                      height: 120,
                      isCircle: true,
                      placeholderText: '프로필 사진 선택',
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // 닉네임
                    AppTextField(
                      label: '닉네임',
                      isRequired: true,
                      controller: vm.nicknameController,
                      hintText: '닉네임을 입력해주세요.',
                      errorText: vm.errorMessage,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // 설명
                    AppTextField(
                      label: '설명',
                      controller: vm.descriptionController,
                      hintText: '자신을 소개하는 설명 문구를 입력해주세요.',
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              child: PrimaryButton(
                label: '프로필 설정',
                disabled: !vm.canSubmit,
                onPressed: vm.canSubmit
                    ? () => vm.submitProfile(context)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
