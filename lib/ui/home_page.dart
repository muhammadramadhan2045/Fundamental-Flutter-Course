import 'package:flutter/material.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(ArticleDetailPage.routeName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selectNotificationSubject.close();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Article List'),
          onPressed: () {
            Navigator.pushNamed(context, '/article_list');
          },
        ),
      ),
    );
  }
}
