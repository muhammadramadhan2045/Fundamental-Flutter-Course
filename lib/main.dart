import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:simple_android_alarm_manager_app/ui/home_page.dart';
import 'package:simple_android_alarm_manager_app/utils/background_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const title = 'Simple Alarm Manager';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
