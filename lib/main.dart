import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/notification_service.dart';
import 'screens/dashboard_page.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.instance.initialize();
  await NotificationService.instance.requestPermission();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..initialize(),
      child: const CyberLifeApp(),
    ),
  );
}

class CyberLifeApp extends StatelessWidget {
  const CyberLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CyberLife',
      theme: AppTheme.theme,
      home: const DashboardPage(),
    );
  }
}
