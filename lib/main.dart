import 'package:flutter/material.dart';
import 'package:pedal/common/theme/app_theme.dart';
import 'package:pedal/core/routes/app_router.dart';

void main() {
  runApp(const PedalApp());
}

class PedalApp extends StatelessWidget {
  const PedalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pedal',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
