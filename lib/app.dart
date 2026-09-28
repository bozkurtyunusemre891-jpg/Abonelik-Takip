import 'package:abonelik_takip/core/routing/app_router.dart';
import 'package:abonelik_takip/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AbonelikTakipApp extends StatelessWidget {
  const AbonelikTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Abonelik Takip',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
