import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:pedal/common/theme/app_spacing.dart';
import 'package:pedal/common/theme/app_radius.dart';

class ImageUploadBox extends StatelessWidget {
  final String? uploadedImagePath;
  final VoidCallback onTap;

  const ImageUploadBox({
    super.key,
    required this.uploadedImagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: AppRadius.lgAll,
          border: Border.all(
            color: AppColors.border,
            style: BorderStyle.solid,
            width: 1.5,
          ),
          color: AppColors.gray50,
        ),
        child: uploadedImagePath != null
            ? ClipRRect(
                borderRadius: AppRadius.lgAll,
                child: Image.asset(
                  uploadedImagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _placeholder(),
                ),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.image_outlined,
          color: AppColors.textDisabled,
          size: 40,
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          '스크린샷을 업로드해주세요',
          style: AppTextStyles.txtSm.copyWith(color: AppColors.textSecondary),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          '탭하여 갤러리에서 선택',
          style: AppTextStyles.txtXs.copyWith(color: AppColors.textDisabled),
        ),
      ],
    );
  }
}
