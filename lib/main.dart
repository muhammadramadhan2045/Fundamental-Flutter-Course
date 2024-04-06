import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/ui/article_list_page.dart';
import 'package:news_app/ui/article_web_view.dart';
import 'package:news_app/ui/home_page.dart';
import 'package:news_app/common/style.dart';
import 'package:news_app/ui/setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: myTextTheme,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        ArticleListPage.routeName: (context) => const ArticleListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
              article: ModalRoute.of(context)?.settings.arguments as Articles,
            ),
        SettingPage.routeName: (context) => const SettingPage(),
        ArticleWebView.routeName: (context) => ArticleWebView(
            url: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
