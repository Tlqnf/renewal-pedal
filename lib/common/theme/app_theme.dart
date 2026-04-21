import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            headlineLarge: AppTextStyles.tit2xl,
            headlineMedium: AppTextStyles.titXl,
            headlineSmall: AppTextStyles.titLg,
            titleLarge: AppTextStyles.titMd,
            titleMedium: AppTextStyles.titSm,
            titleSmall: AppTextStyles.titXs,
            bodyLarge: AppTextStyles.txtLg,
            bodyMedium: AppTextStyles.txtMd,
            bodySmall: AppTextStyles.txtSm,
            labelLarge: AppTextStyles.txtXs,
            labelMedium: AppTextStyles.txt2xs,
          ),
        ),
        scaffoldBackgroundColor: AppColors.background,
        dividerColor: AppColors.divider,
      );
}
