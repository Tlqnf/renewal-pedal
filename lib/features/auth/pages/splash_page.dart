import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pedal/common/theme/app_colors.dart';
import 'package:pedal/core/constants/constants.dart';
import 'package:pedal/core/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    this.nextRoutePath = AppRoutes.login,
    this.delay = _defaultDelay,
  });

  final String nextRoutePath;
  final Duration delay;

  static const Duration _defaultDelay = Duration(seconds: 2);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(widget.delay, _navigateToNextPage);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _navigateToNextPage() {
    if (!mounted) {
      return;
    }

    context.go(widget.nextRoutePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SizedBox.expand(
          child: Image.asset(AppConstants.splash, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
