import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/pages/restaurant_list_page.dart';
import 'package:restaurant_app/pages/restaurant_search_page.dart';
import 'package:restaurant_app/pages/settings_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  await AndroidAlarmManager.initialize();
  service.initializeIsolate();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (context) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
            create: (context) => SearchRestaurantProvider()),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
                onPrimary: Colors.black,
              ),
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)!.settings.arguments as String,
              ),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
