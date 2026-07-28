import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/database/local_database.dart';
import 'features/safe_places/data/safe_places_data.dart';
import 'services/sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDatabase.instance.ensureInitialized(
    seedPlaces: SafePlacesData.allPlaces,
  );


  SyncService.instance.start();

  runApp(const DisasterHelperApp());
}

class DisasterHelperApp extends StatelessWidget {
  const DisasterHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Disaster Helper',
      debugShowCheckedModeBanner: false,

      // App Theme //
      theme: AppTheme.lightTheme,

      // First Screen
      home: const SplashScreen(),
    );
  }
}