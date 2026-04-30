import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';

class ErrorStateView extends StatelessWidget {
  final String message;

  const ErrorStateView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTextStyles.txtMd.copyWith(color: AppColors.error),
        textAlign: TextAlign.center,
      ),
    );
  }
}
