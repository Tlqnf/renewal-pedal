import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Title styles (tit-*)
  static const TextStyle tit2xs = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle titXs  = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle titSm  = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle titMd  = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle titLg  = TextStyle(fontSize: 21, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle titXl  = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static const TextStyle tit2xl = TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  // Text styles (txt-*)
  static const TextStyle txt2xs = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txtXs  = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txtSm  = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txtMd  = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txtLg  = TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txtXl  = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const TextStyle txt2xl = TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
}
