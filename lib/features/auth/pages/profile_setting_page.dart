import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_radius.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class ProfileSettingPage extends StatefulWidget {
  final File? profileImage;
  final TextEditingController nicknameController;
  final TextEditingController bioController;
  final bool isLoading;
  final String? nicknameError;
  final VoidCallback onPickImage;
  final ValueChanged<String> onNicknameChanged;
  final ValueChanged<String> onBioChanged;
  final VoidCallback onSubmit;

  const ProfileSettingPage({
    super.key,
    required this.profileImage,
    required this.nicknameController,
    required this.bioController,
    required this.isLoading,
    required this.nicknameError,
    required this.onPickImage,
    required this.onNicknameChanged,
    required this.onBioChanged,
    required this.onSubmit,
  });

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
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
                  Text(
                    '프로필 설정',
                    style: AppTextStyles.txtSm.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _LabeledSection(
                    label: '프로필 사진',
                    isRequired: true,
                    child: _ProfileImagePicker(
                      image: widget.profileImage,
                      onTap: widget.onPickImage,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _LabeledTextField(
                    label: '닉네임',
                    isRequired: true,
                    controller: widget.nicknameController,
                    hintText: '닉네임을 입력해주세요.',
                    errorText: widget.nicknameError,
                    onChanged: widget.onNicknameChanged,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _LabeledTextField(
                    label: '설명',
                    isRequired: false,
                    controller: widget.bioController,
                    hintText: '자신을 소개하는 설명 문구를 입력해주세요.',
                    onChanged: widget.onBioChanged,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
          _SubmitButton(
            label: '프로필 설정',
            isLoading: widget.isLoading,
            onPressed: widget.onSubmit,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Private Widgets
// ─────────────────────────────────────────────

class _LabeledSection extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget child;

  const _LabeledSection({
    required this.label,
    required this.isRequired,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, isRequired: isRequired),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const _FieldLabel({required this.label, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: AppTextStyles.titXs),
        if (isRequired) ...[
          const SizedBox(width: AppSpacing.xs),
          Text(
            '*',
            style: AppTextStyles.titXs.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const _ProfileImagePicker({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: AppRadius.smAll,
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: image != null
            ? Image.file(image!, fit: BoxFit.cover)
            : const Center(
                child: Icon(
                  Icons.image_outlined,
                  size: 32,
                  color: AppColors.textPrimary,
                ),
              ),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const _LabeledTextField({
    required this.label,
    required this.isRequired,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.maxLines,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, isRequired: isRequired),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          style: AppTextStyles.txtSm,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.txtSm.copyWith(
              color: AppColors.textDisabled,
            ),
            errorText: errorText,
            errorStyle: AppTextStyles.txtXs.copyWith(color: AppColors.error),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.smAll,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.smAll,
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.smAll,
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: AppRadius.smAll,
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.primary200,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
            elevation: 0,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.surface,
                  ),
                )
              : Text(
                  label,
                  style: AppTextStyles.titSm.copyWith(color: AppColors.surface),
                ),
        ),
      ),
    );
  }
}
