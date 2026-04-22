import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.tit2xl,
      displayMedium: AppTextStyles.titXl,
      headlineLarge: AppTextStyles.titLg,
      headlineMedium: AppTextStyles.titMd,
      headlineSmall: AppTextStyles.titSm,
      bodyLarge: AppTextStyles.txtXl,
      bodyMedium: AppTextStyles.txtLg,
      labelLarge: AppTextStyles.txtMd,
      bodySmall: AppTextStyles.txtSm,
    ),
    dividerColor: AppColors.divider,
  );
}
