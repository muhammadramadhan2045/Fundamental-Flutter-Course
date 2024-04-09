import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/provider/preferences_provider.dart';
import 'package:news_app/provider/scheduling_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/ui/article_list_page.dart';
import 'package:news_app/ui/article_web_view.dart';
import 'package:news_app/ui/home_page.dart';
import 'package:news_app/ui/setting_page.dart';
import 'package:news_app/utils/background_service.dart';
import 'package:news_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _backgroundService = BackgroundService();

  _backgroundService.initializeIsolate();

  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SchedullingProvider>(
          create: (context) => SchedullingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
            SharedPreferences.getInstance(),
          )),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          navigatorKey: navigatorKey,
          theme: provider.themeData,
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            ArticleListPage.routeName: (context) => const ArticleListPage(),
            ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                  article:
                      ModalRoute.of(context)?.settings.arguments as Articles,
                ),
            SettingPage.routeName: (context) => const SettingPage(),
            ArticleWebView.routeName: (context) => ArticleWebView(
                url: ModalRoute.of(context)?.settings.arguments as String),
          },
        );
      }),
    );
  }
}
