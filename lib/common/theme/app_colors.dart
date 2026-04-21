import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Gray
  static const Color gray0   = Color(0xFFFFFFFF);
  static const Color gray50  = Color(0xFFF5F5F5);
  static const Color gray100 = Color(0xFFEEEEEE);
  static const Color gray200 = Color(0xFFE0E0E0);
  static const Color gray300 = Color(0xFFBDBDBD);
  static const Color gray400 = Color(0xFF9E9E9E);
  static const Color gray500 = Color(0xFF757575);
  static const Color gray600 = Color(0xFF616161);
  static const Color gray700 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF202020);

  // Semantic
  static const Color error   = Color(0xFFFF312D);
  static const Color warning = Color(0xFFFFAA00);
  static const Color success = Color(0xFF56C85A);
  static const Color info    = Color(0xFF00A5FF);

  // Primary
  static const Color primary100 = Color(0xFFE3F2FD);
  static const Color primary200 = Color(0xFF86B5FE);
  static const Color primary400 = Color(0xFF2979FF);
  static const Color primary500 = Color(0xFF1D5DDB);
  static const Color primary700 = Color(0xFF1445B7);

  // Secondary
  static const Color secondary100 = Color(0xFFFD9B86);
  static const Color secondary200 = Color(0xFFFB7568);
  static const Color secondary400 = Color(0xFFFA3737);
  static const Color secondary500 = Color(0xFFD72837);
  static const Color secondary700 = Color(0xFFB31B36);

  // Aliases
  static const Color primary = primary400;
  static const Color secondary = secondary400;
  static const Color surface = gray0;
  static const Color background = gray50;
  static const Color border = gray200;
  static const Color divider = gray200;

  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textDisabled = gray400;
}
