import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.surface,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.tit2xl,
      displayMedium: AppTextStyles.titXl,
      headlineLarge: AppTextStyles.titLgMedium,
      headlineMedium: AppTextStyles.titMdMedium,
      headlineSmall: AppTextStyles.titSmMedium,
      bodyLarge: AppTextStyles.txtXl,
      bodyMedium: AppTextStyles.txtLg,
      labelLarge: AppTextStyles.txtMd,
      bodySmall: AppTextStyles.txtSm,
    ),
    dividerColor: AppColors.border,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
