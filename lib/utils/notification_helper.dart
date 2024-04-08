import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'received_notification.dart';
import 'package:timezone/timezone.dart' as tz;

final selectNotificatiionSubject = BehaviorSubject<String>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = '01';
  static const _channelName = 'channel_01';
  static const _channelDesc = 'dicoding_channel';
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload ?? '';
      if (payload.isNotEmpty) {
        debugPrint('notification payload: $payload');
      }
      selectNotificatiionSubject.add(payload);
    });
  }

  void requestAndroidPermission(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void configureDidReceivedLocalNotificationSubject(
      BuildContext context, String route) {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(receivedNotification.title ?? ''),
            content: Text(receivedNotification.body ?? ''),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.pushNamed(context, route,
                      arguments: receivedNotification);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidPlatformChannelSpesifics = const AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpesifics =
        NotificationDetails(android: androidPlatformChannelSpesifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      platformChannelSpesifics,
      payload: 'plain notification',
    );
  }

  Future<void> showNotificationWithNoBody(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidPlatformChannelSpesifics = const AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpesifics =
        NotificationDetails(android: androidPlatformChannelSpesifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      null,
      platformChannelSpesifics,
      payload: 'item x',
    );
  }

  Future<void> scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var dateTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpesifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      icon: 'secondary_icon',
      sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
      largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    var platformChannelSpesifics =
        NotificationDetails(android: androidPlatformChannelSpesifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      dateTime,
      platformChannelSpesifics,
      payload: 'scheduled notification',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showGroupedNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var groupKey = 'com.android.example.WORK_EMAIL';

    var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var firstNotificationPlatformSpecifics =
        NotificationDetails(android: firstNotificationAndroidSpecifics);

    await flutterLocalNotificationsPlugin.show(
      1,
      'Alex Faarborg',
      'You will not believe...',
      firstNotificationPlatformSpecifics,
    );

    var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey,
    );

    var secondNotificationPlatformSpecifics =
        NotificationDetails(android: secondNotificationAndroidSpecifics);

    await flutterLocalNotificationsPlugin.show(
      2,
      'Jeff Chang',
      'Please join us to celebrate the...',
      secondNotificationPlatformSpecifics,
    );

    var lines = <String>[];
    lines.add('Alex Faarborg  You will not believe...');
    lines.add('Jeff Chang  Please join us to celebrate the...');

    var inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '2 new messages',
      summaryText: 'janedoe@example.com',
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      3,
      'Attention',
      'Two new messages',
      platformChannelSpecifics,
    );
  }

  Future<void> showProgressNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var maxProgress = 5;
    for (var i = 0; i <= maxProgress; i++) {
      await Future.delayed(const Duration(seconds: 1), () async {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          NotificationHelper._channelId,
          NotificationHelper._channelName,
          channelDescription: NotificationHelper._channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i,
          channelShowBadge: false,
        );

        var platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
          0,
          'progress notification title',
          'progress notification body',
          platformChannelSpecifics,
          payload: 'item x',
        );
      });
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showBigPictureNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var largeIconPath = await _downloadAndSaveFile(
        'https://via.placeholder.com/48x48', 'largeIcon');
    var bigPicturePath = await _downloadAndSaveFile(
        'https://via.placeholder.com/400x800', 'bigPicture');

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      styleInformation: bigPictureStyleInformation,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'big text title',
      'silent body',
      platformChannelSpecifics,
    );
  }

  Future<void> showNotificationWithAttachment(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var bigPicturePath = await _downloadAndSaveFile(
        'https://via.placeholder.com/400x800', 'bigPicture.jpg');

    var bigPictureAndroidStyle = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      NotificationHelper._channelId,
      NotificationHelper._channelName,
      channelDescription: NotificationHelper._channelDesc,
      styleInformation: bigPictureAndroidStyle,
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'notification with attachment title',
      'notification with attachment body',
      platformChannelSpecifics,
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificatiionSubject.stream.listen((String? payload) async {
      await Navigator.pushNamed(context, route,
          arguments: ReceivedNotification(payload: payload));
    });
  }
}
