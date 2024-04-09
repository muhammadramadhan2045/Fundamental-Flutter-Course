import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/model/article.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

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
      selectNotificationSubject.add(payload);
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

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Article article) async {
    var androidPlatformChannelSpesifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var platformChannelSpesifics =
        NotificationDetails(android: androidPlatformChannelSpesifics);

    var titleNotification = "<b>Headline News</b>";
    var titleNews = article.articles?[0].title ?? "";

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpesifics,
      payload: jsonEncode(article.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      var data = Article.fromJson(jsonDecode(payload ?? ""));
      var article = data.articles?[0];
      Navigation.intentWithData(route, article ?? Articles());
    });
  }
}
