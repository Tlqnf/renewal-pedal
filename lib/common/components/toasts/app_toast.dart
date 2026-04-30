import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/common/theme/app_text_styles.dart';
import 'package:toastification/toastification.dart';

// TODO: 스타일 변경 필요
enum AppToastType { success, error, warning, info }

class AppToast {
  AppToast._();

  static void show(
    BuildContext context, {
    required String message,
    AppToastType type = AppToastType.info,
    String? description,
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.dismissAll(delayForAnimation: false);
    final config = _toastConfig(type);
    toastification.show(
      context: context,
      type: config.type,
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: AppTextStyles.titXs.copyWith(color: Colors.white),
      ),
      description: description != null
          ? Text(
              description,
              style: AppTextStyles.txtXs.copyWith(color: Colors.white70),
            )
          : null,
      icon: Icon(config.icon, color: Colors.white, size: 20),
      backgroundColor: config.backgroundColor,
      borderRadius: BorderRadius.circular(999),
      showProgressBar: false,
      autoCloseDuration: duration,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
    );
  }

  static void success(
    BuildContext context,
    String message, {
    String? description,
  }) => show(
    context,
    message: message,
    description: description,
    type: AppToastType.success,
  );

  static void error(
    BuildContext context,
    String message, {
    String? description,
  }) => show(
    context,
    message: message,
    description: description,
    type: AppToastType.error,
  );

  static void warning(
    BuildContext context,
    String message, {
    String? description,
  }) => show(
    context,
    message: message,
    description: description,
    type: AppToastType.warning,
  );

  static void info(
    BuildContext context,
    String message, {
    String? description,
  }) => show(
    context,
    message: message,
    description: description,
    type: AppToastType.info,
  );
}

class _ToastConfig {
  final ToastificationType type;
  final Color backgroundColor;
  final IconData icon;

  const _ToastConfig({
    required this.type,
    required this.backgroundColor,
    required this.icon,
  });
}

_ToastConfig _toastConfig(AppToastType type) {
  switch (type) {
    case AppToastType.success:
      return _ToastConfig(
        type: ToastificationType.success,
        backgroundColor: AppColors.success,
        icon: Icons.check_circle_outline_rounded,
      );
    case AppToastType.error:
      return _ToastConfig(
        type: ToastificationType.error,
        backgroundColor: AppColors.error,
        icon: Icons.error_outline_rounded,
      );
    case AppToastType.warning:
      return _ToastConfig(
        type: ToastificationType.warning,
        backgroundColor: AppColors.warning,
        icon: Icons.warning_amber_rounded,
      );
    case AppToastType.info:
      return _ToastConfig(
        type: ToastificationType.info,
        backgroundColor: AppColors.info,
        icon: Icons.info_outline_rounded,
      );
  }
}
