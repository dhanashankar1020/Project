import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const DisasterHelperApp());
}

class DisasterHelperApp extends StatelessWidget {
  const DisasterHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Disaster Helper',
      debugShowCheckedModeBanner: false,

      // App Theme
      theme: AppTheme.lightTheme,

      // First Screen
      home: const SplashScreen(),
    );
  }
}